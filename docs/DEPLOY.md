# Deployment method

## Rails container build and push
```bash
# docker build
$ docker-compose build --build-arg BUNDLE_OPTIONS='--without development test' backend
# create docker tag
$ docker tag tebukuro_backend us.gcr.io/tebukuro-182304/tebukuro_backend:latest
# docker push
$ gcloud docker -- push us.gcr.io/tebukuro-182304/tebukuro_backend:latest
```

## Container setting
```bash
# get credentials
$ gcloud container clusters get-credentials tebukuro-cluster
# create secret
$ kubectl create -f ~/.kube/tebukuro-secret.yml
```

## Create application container
```bash
# create tebukuro deployment
$ export TEBUKURO_IMAGE=us.gcr.io/tebukuro-182304/tebukuro_backend:latest
$ export INSTANCE_CONNECTION_NAME=tebukuro-182304:your_zone:your_db_instance_name
$ cat kubernetes/tebukuro.yml | envsubst | kubectl create -f -
# create tebukuro service
$ kubectl create -f kubernetes/tebukuro-service.yml
# create tebukuro ingress
$ kubectl create -f kubernetes/ingress.yml
```

## Deploy(migrate) task
```bash
$ export TEBUKURO_IMAGE=us.gcr.io/tebukuro-182304/tebukuro_backend:latest
$ export INSTANCE_CONNECTION_NAME=tebukuro-182304:your_zone:your_db_instance_name
$ ./script/deploy.sh
```

## deploy web containers
```bash
#kubectl set image deployments/tebukuro "web=$TEBUKURO_IMAGE"
$ cat kubernetes/tebukuro.yml | envsubst | kubectl apply -f -
$ kubectl describe deployment tebukuro
$ kubectl rollout status deployment/tebukuro
```
