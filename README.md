turbo-cloaked
=====

Provides an example of using aeson for json with haskell.  In the particular example, I am requesting user data from github.

Git it
===
```
    user@host:~/src$ git clone https://github.com/gitjonathan/turbo-cloaked/
```
Build and Install
===
```
  user@host:~/src$ cd turbo-cloaked
  user@host:~/src/turbo-cloaked$ cabal install
```  
Run
===
```
  user@host:~/src/turbo-cloaked$ cd dist/build/githubUser
  user@host:~/src/turbo-cloaked/dist/build/githubUser$ ./githubUser
```  

You should see JSON output for a github user.


