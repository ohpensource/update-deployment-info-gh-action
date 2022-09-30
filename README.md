### update-deployment-info-gh-action

Action ensures that performed deployments are document in git repository by creating deploy(-service-group).info files with current deployed version and date of deployment.
It creates file by convention in the folder: configuration/$CUSTOMER/$ENVIRONMENT/

```yaml
  update-deployment-info:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ohpensource/update-deployment-info-gh-action@main
        with:          
          environment: "dev"
          customer: "CUSTOMER_NAME"
          service-group: "main"
          software-version: "v0.0.1"
```
