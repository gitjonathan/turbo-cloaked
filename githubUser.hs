-- The MIT License (MIT)
-- 
-- Copyright (c) 2013 Jonathan McCluskey
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
-- FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
-- COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
-- CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import Data.Aeson
import Data.Text
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
import GHC.Generics

-- | Type of each JSON entry in record syntax.
data GithubUser =
  GithubUser { login         :: !Text
             , id            :: Int 
             , avatar_url    :: !Text
             , gravatar_id   :: !Text
             , url           :: !Text
             , html_url      :: !Text
             , followers_url :: !Text
             , following_url :: !Text
             , gists_url     :: !Text
             , starred_url   :: !Text
             , subscriptions_url   :: !Text
             , organizations_url   :: !Text
             , repos_url           :: !Text
             , events_url          :: !Text
             , received_events_url :: !Text
             , type_     :: !Text
             , name     :: !Text
             , company  :: !Text
             , blog     :: !Text
             , location :: !Text
             , email    :: !Text
             , hireable :: Bool 
             , bio      :: !Text
             , public_repos :: Int
             , followers    :: Int
             , following    :: Int
             , created_at   :: !Text
             , updated_at   :: !Text
             , public_gists :: Int 
           } deriving (Show,Generic)

-- Instances to convert our type to/from JSON.

instance FromJSON GithubUser
  where
    parseJSON (Object v) = GithubUser <$>
             v .: "login" <*>
             v .: "id" <*>
             v .: "avatar_url" <*>
             v .: "gravatar_id" <*>
             v .: "url" <*>
             v .: "html_url" <*>
             v .: "followers_url" <*>
             v .: "following_url" <*>
             v .: "gists_url" <*>
             v .: "starred_url" <*>
             v .: "subscriptions_url" <*>
             v .: "organizations_url" <*>
             v .: "repos_url" <*>
             v .: "events_url" <*>
             v .: "received_events_url" <*>
             v .: "type" <*>
             v .: "name" <*>
             v .: "company" <*> 
             v .: "blog" <*>
             v .: "location" <*>
             v .: "email" <*>
             v .: "hireable" <*>
             v .: "bio" <*>
             v .: "public_repos" <*>
             v .: "followers" <*>
             v .: "following" <*>
             v .: "created_at" <*>
             v .: "updated_at" <*>
             v .: "public_gists"  
    parseJSON _          = mzero

instance ToJSON GithubUser

-- | URL that points to the remote JSON file, in case
--   you have it.
jsonURL :: String
jsonURL = "https://api.github.com/users/defunkt"

-- Read the remote copy of the JSON file.
getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL

main :: IO ()
main = do
 -- Get JSON data and decode it
 d <- (eitherDecode <$> getJSON) :: IO (Either String GithubUser)
 -- If d is Left, the JSON was malformed.
 -- In that case, we report the error.
 -- Otherwise, we perform the operation of
 -- our choice. In this case, just print it.
 case d of
  Left err -> putStrLn err
  Right ps -> print ps

