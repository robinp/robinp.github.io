{-# LANGUAGE OverloadedStrings #-}
import Control.Monad (filterM)
import Control.Monad.Error.Class
import Data.List (isInfixOf, isPrefixOf)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import Hakyll

data Lang = EN | HU
  deriving (Show, Eq)

langs = [EN, HU]
defaultLang = EN

langCode :: Lang -> String
langCode EN = "en"
langCode HU = "hu"

toLangPostfix :: Lang -> String
toLangPostfix lang = case lang of
  l | l == defaultLang -> ""
  other -> '-':langCode other

parseLang :: String -> Maybe Lang
parseLang lang = case lang of
  "en" -> Just EN
  "hu" -> Just HU
  _ -> Nothing

langFromFileName :: String -> Lang
langFromFileName fn =
  let found = listToMaybe $ filter hasLang langs
  in fromMaybe defaultLang found
  where
    hasLang lang = ("-" ++ (langCode lang) ++ ".") `isInfixOf` fn

exactlyOne :: [a] -> Maybe a
exactlyOne [a] = Just a
exactlyOne _ = Nothing

nothingToError _ (Just a)  = return a
nothingToError err Nothing = throwError err

type Dictionaty = Map String String

dict :: Lang -> Dictionaty
dict EN = M.fromList
  [ ("mBlogTitle", "Robin Palotai's weblog")
  , ("mStartPage", "Home")
  , ("mAboutBlog", "About")
  , ("mContactInNavbar", "Contact")
  , ("mArchiveTitle", "Archive")
  , ("mSiteGeneratedBy", "Site proudly generated by")
  , ("mArchivePostsPrelude", "All my previous posts:")
  ]
dict HU = M.fromList
  [ ("mBlogTitle", "Palotai Robin blogol")
  , ("mStartPage", "Kezdőlap")
  , ("mAboutBlog", "Magamról")
  , ("mContactInNavbar", "Kapcsolat")
  , ("mArchiveTitle", "Archívum")
  , ("mSiteGeneratedBy", "Weboldal motor:")
  , ("mArchivePostsPrelude", "Korábbi bejegyzéseim:")
  ]

metaLang :: Item a -> Compiler Lang
metaLang item =
  let ident = itemIdentifier item
  in (fromMaybe defaultLang . (>>= parseLang))
       `fmap` getMetadataField ident "lang"

metaBooks :: Item a -> Compiler [String]
metaBooks item = do
  let ident = itemIdentifier item
  kvs <- getMetadata ident
  return . M.elems . M.filterWithKey (\k _ -> "book" `isPrefixOf` k) $ kvs

translate :: (Item a -> Compiler Lang) -> [String] -> Item a -> Compiler String
translate langf words item = do
  word <- nothingToError ["bad call to translate"] . exactlyOne $ words
  lang <- langf item
  nothingToError ["not in dictionary"] . M.lookup word $ dict lang

trans :: Context a
trans = functionField "trans" (translate metaLang)

transUsing :: Lang -> Context a
transUsing lang = functionField "trans" (translate . const $ return lang)

trans' :: Lang -> String -> Compiler String
trans' lang key = nothingToError ["not in dictionart"]
                    $ M.lookup key (dict lang)

myDefaultContext = defaultContext <> trans

setLangContext :: Lang -> Context a
setLangContext lang =
  constField "curlang" (toLangPostfix lang)

postCtx :: Context String
postCtx = myDefaultContext
  <> dateField "date" "%B %e, %Y"

data Book = Book String

bookCtx :: Context Book
bookCtx = field "link" (\i -> case itemBody i of (Book b) -> return b)

booksCtx :: [String] -> Context a
booksCtx links =
  let lf = listField "books" bookCtx
         . sequence
         . map (makeItem . Book) $ links
  in if null links
      then lf
      else lf <> (constField "hasBooks" "1")

main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "contact*.markdown" $ do
    route   $ setExtension "html"
    compile $ do
      lang <- langFromFileName `fmap` getResourceFilePath
      pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html"
              (myDefaultContext <> setLangContext lang)
        >>= relativizeUrls

  match "posts/*/*" $ do
    route $ setExtension "html"
    compile $ do
      lang <- getResourceBody >>= metaLang
      links <- getResourceBody >>= metaBooks
      pandocCompiler
        >>= loadAndApplyTemplate "templates/post.html" (postCtx <> booksCtx links)
        >>= loadAndApplyTemplate "templates/default.html"
              (postCtx <> setLangContext lang)
        >>= relativizeUrls

  create {-["archive.html", "archive-hu.html"]-} [] $ do
    route idRoute
    compile $ do
      lang <- (langFromFileName . toFilePath) `fmap` getUnderlying
      title <- trans' lang "mArchiveTitle"
      posts <- sortedPostsWithLang lang
      let archiveCtx =
            setLangContext lang
            <> listField "posts" postCtx (return posts)
            <> constField "title" title
            <> setLangContext lang
            <> transUsing lang
            <> myDefaultContext
      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= relativizeUrls

  match "index*.html" $ do
    route idRoute
    compile $ do
      lang <- langFromFileName `fmap` getResourceFilePath
      posts <- sortedPostsWithLang lang
      let indexCtx = myDefaultContext
            <> setLangContext lang
            <> listField "posts" postCtx (return posts)
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateCompiler

sortedPostsWithLang :: Lang -> Compiler [Item String]
sortedPostsWithLang lang =
  loadAll "posts/*/*" >>= recentFirst >>= onlyMatchingLang lang
  where
    onlyMatchingLang :: Lang -> [Item a] -> Compiler [Item a]
    onlyMatchingLang lang = filterM (fmap (lang ==) . metaLang)
