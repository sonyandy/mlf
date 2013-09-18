module Parser
       ( Parser
       , runParser
       , ParserState (..)
       , ParseError (..)
       ) where

import Control.Monad.State.Strict

import Data.ByteString (ByteString)
import Data.Text.Encoding.Error

import Loc
import Token

type Parser = StateT ParserState (Either (Loc, ParseError))

runParser :: Parser a -> ByteString -> Either (Loc, ParseError) a
runParser m xs = evalStateT m (ParserState (Pos 1 1) xs)

data ParserState = ParserState {-# UNPACK #-} !Pos {-# UNPACK #-} !ByteString

data ParseError
  = LexError
  | UnicodeException UnicodeException
  | UnexpectedToken Token deriving Show
