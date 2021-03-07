# Cloud Run Sample

For creating buket 
https://cloudrun-srv-3poc2pq2oa-ue.a.run.app/createblob?name=zzz123456test 

Useful Gloud commands
gcloud components update
gcloud config set run/platform managed
gcloud config set run/region us-east1

gcloud config get-value project
gcloud builds submit --tag gcr.io/oleksii-sandbox/helloworld
gcloud run services update  --platform managed service.yaml

gcloud beta run  deploy --image gcr.io/oleksii-sandbox/helloworld:0.1
gcloud beta run  deploy --image gcr.io/oleksii-sandbox/helloworld:0.2 --no-traffic --tag green
gcloud beta run  services update-traffic helloworld --to-tags green=30



This sample shows how to deploy a Hello World [Spring Boot](https://spring.io/projects/spring-boot)
application to Cloud Run.

For more details on how to work with this sample read the [Google Cloud Run Java Samples README](https://github.com/GoogleCloudPlatform/java-docs-samples/tree/master/run).

[![Run in Google Cloud][run_img]][run_link]

[run_img]: https://storage.googleapis.com/cloudrun/button.svg
[run_link]: https://deploy.cloud.run/?git_repo=https://github.com/GoogleCloudPlatform/java-docs-samples&dir=run/helloworld

## Dependencies

* **Spring Boot**: Web server framework.
* **Junit**: [development] Test running framework.
