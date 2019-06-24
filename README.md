## Note about Elm knowledge that have learnt by myself

Learn from course [Elm For Beginners](https://courses.knowthen.com/p/elm-for-beginners)

### Pure functions

- Pure function rules
  - Must have input parameter(s)
  - Must not use state
  - Must return value
  - Must not case Side Effects
- Advantage
  - Reusable
  - Composable: 
  - Testable: it means easy to test
  - Cacheable
  - Parallelizable

### State is like Radioactive Material

- Uncontrolled state
- Dirties your code
- Harder to work with

### Attention about commands of the new version of elm (0.19.0)

- **elm init** - initialize new project, this command creates elm.json file for us
- **elm.json** - Has the same meaning with package.json file
- **elm reactor** - to run server of elm application
- **localhost:port//file_name.elm**. Each of the file_name.elm files will have main function
- **elm repl** - turn on the elm console
- https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md - released note of 0.19.0 version
