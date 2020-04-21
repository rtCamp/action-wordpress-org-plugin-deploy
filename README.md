This action is a part of [GitHub Actions Library](https://github.com/rtCamp/github-actions-library/) created by [rtCamp](https://github.com/rtCamp/).

# WordPress.org Plugin Deployment - GitHub Action

A [GitHub Action](https://github.com/features/actions) that publishes your plugin to [WordPress.org](https://wordpress.org/) when a new tag is created on GitHub.

## Configuration

### Required secrets
* `WORDPRESS_USERNAME`
* `WORDPRESS_PASSWORD`

### Environment variables
| Variable       | Default                                              | Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|----------------|------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SLUG           | Repository name                                      | To Define plugin slug, of your WordPress Plugin repository.                                                                                                                                                                                                                                                                                                                                                                                                 |
| ASSETS_DIR     | null                                                 | Content of the directory will be used to update `assets` directory in plugin svn repository.                                                                                                                                                                                                                                                                                                                                                                |
| CUSTOM_COMMAND | null                                                 | This can be used to pass custom command which can be used to build plugin assets before files are copied to plugin `trunk`. Eg `gulp build`                                                                                                                                                                                                                                                                                                                 |
| CUSTOM_PATH    | null                                                 | Some plugins tend to have a different folder inside git repository where the source files are kept aside from development files. If provided files will be copied from `CUSTOM_PATH` to plugin `trunk`.                                                                                                                                                                                                                                                     |
| EXCLUDE_LIST   | .git, .github, exclude.txt, node_modules, ASSETS_DIR | Add file / folders that you wish to exclude from final list of files to be sent to plugin `trunk`. Eg development files.   Final value of this var is expected to be a string delimited with spaces. Eg: '.gitignore package.json README.md'   Please Note, excluded file/folder path, is considered from the root of repository unless `CUSTOM_PATH` is provided, in which case excluded file/folder path should be relative to the final source of files. |

**⚠️ Tips:**

- Don't forget to add build directories in `EXCLUDE_LIST`, Eg. `vendor` for `composer install`.
  - `node_modules` is excluded by default.

### Usage
Here is an example setup of this action:

- Create a `create.yml` file inside `.github/workflows` directory of your GitHub repo.
- Add the following code to `create.yml` file.

```yml
name: Deploy
on:
  push:
    tags:
      - '*'
jobs:
  tag:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: WordPress Plugin Deploy
      uses: rtCamp/action-wordpress-org-plugin-deploy@master
      env:
        CUSTOM_COMMAND: composer install --no-dev --optimize-autoloader && npm install
          && gulp build
        CUSTOM_PATH: post-contributor
        EXCLUDE_LIST: asset_sources/
        SLUG: plugin-slug
        WORDPRESS_PASSWORD: ${{ secrets.WORDPRESS_PASSWORD }}
        WORDPRESS_USERNAME: ${{ secrets.WORDPRESS_USERNAME }}
```

## Credits

* GitHub action bootstrapped from - [10up/actions-wordpress/dotorg-plugin-deploy](https://github.com/10up/actions-wordpress/tree/master/dotorg-plugin-deploy)  

## Does this interest you?

<a href="https://rtcamp.com/"><img src="https://rtcamp.com/wp-content/uploads/2019/04/github-banner@2x.png" alt="Join us at rtCamp, we specialize in providing high performance enterprise WordPress solutions"></a>
