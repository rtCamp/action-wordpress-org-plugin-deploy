> **⚠️ Note:** To use this GitHub Action, you must have access to GitHub Actions. GitHub Actions are currently only available in public beta (you must apply for access).

This action is a part of [GitHub Actions Library](https://github.com/rtCamp/github-actions-library/) created by [rtCamp](https://github.com/rtCamp/).

# WordPress.org Plugin Deployment - GitHub Action

A [GitHub Action](https://github.com/features/actions) which uses the content in the latest pushed tag, runs the build process inside the repository root and copies latest files excluding specified files and commits to [WordPress.org](https://wordpress.org/) plugin directory.
If an assets directory is provided, it will be used to update assets directory of the plugin at [WordPress.org](https://wordpress.org/)

## Configuration

### Required secrets
* `WORDPRESS_USERNAME`
* `WORDPRESS_PASSWORD`

### Environment variables
| Variable       | Default                                | Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|----------------|----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SLUG           | Repository name                        | To Define plugin slug, of your WordPress Plugin repository.                                                                                                                                                                                                                                                                                                                                                                                                 |
| ASSETS_DIR     | null                                   | Content of the directory will be used to update `assets` directory in plugin svn repository.                                                                                                                                                                                                                                                                                                                                                                |
| CUSTOM_COMMAND | null                                   | This can be used to pass custom command which can be used to build plugin assets before files are copied to plugin `trunk`. Eg `gulp build`                                                                                                                                                                                                                                                                                                                 |
| CUSTOM_PATH    | null                                   | Some plugins tend to have a different folder inside git repository where the source files are kept aside from development files. If provided files will be copied from `CUSTOM_PATH` to plugin `trunk`.                                                                                                                                                                                                                                                     |
| EXCLUDE_LIST   | .git, .github, exclude.txt  ASSETS_DIR | Add file / folders that you wish to exclude from final list of files to be sent to plugin `trunk`. Eg development files.   Final value of this var is expected to be a string delimited with spaces. Eg: '.gitignore package.json README.md'   Please Note, excluded file/folder path, is considered from the root of repository unless `CUSTOM_PATH` is provided, in which case excluded file/folder path should be relative to the final source of files. |

### Example Workflow File

```
workflow "Deploy" {
     resolves = ["WordPress Plugin Deploy"]
     on = "push"
   }
   
   # Filter for tag
   action "tag" {
       uses = "actions/bin/filter@master"
       args = "tag"
   }
   
   action "WordPress Plugin Deploy" {
     needs = ["tag"]
     uses = "rtCamp/github-actions-library/wp-plugin-deploy@master"
     secrets = ["WORDPRESS_USERNAME", "WORDPRESS_PASSWORD"]
     env = {
       SLUG = "plugin-slug"
       CUSTOM_COMMAND = "gulp build"
       CUSTOM_PATH = "post-contributor"
       EXCLUDE_LIST = "asset_sources/"
     }
   }
```

## Credits

* Github action bootstrapped from - [10up/actions-wordpress/dotorg-plugin-deploy](https://github.com/10up/actions-wordpress/tree/master/dotorg-plugin-deploy)  
