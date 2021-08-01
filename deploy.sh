docker build -t gcr.io/k8s-sample-320905/multi-client -f ./client/Dockerfile ./client
docker build -t gcr.io/k8s-sample-320905/multi-server -f ./server/Dockerfile ./server
docker build -t gcr.io/k8s-sample-320905/multi-worker -f ./worker/Dockerfile ./worker

docker push gcr.io/k8s-sample-320905/multi-client
docker push gcr.io/k8s-sample-320905/multi-server
docker push gcr.io/k8s-sample-320905/multi-worker

kubectl apply -f k8s

kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/client-deployment
kubectl rollout restart deployment/worker-deployment

# For older version of kubernetes where "rollout restart" command was not available
#  docker build -t dev942/multi-client:latest -t dev942/multi-client:$SHA -f ./client/Dockerfile ./client
#  docker build -t dev942/multi-server:latest -t dev942/multi-server:$SHA -f ./server/Dockerfile ./server
#  docker build -t dev942/multi-worker:latest -t dev942/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#  docker push dev942/multi-client:latest
#  docker push dev942/multi-server:latest
#  docker push dev942/multi-worker:latest
#   docker push dev942/multi-client:$SHA
#  docker push dev942/multi-server:$SHA
#  docker push dev942/multi-worker:$SHA
#  kubectl apply -f k8s
#  kubectl set image deployments/server-deployment server=dev942/multi-server:$SHA
#  kubectl set image deployments/client-deployment client=dev942/multi-client:$SHA
#  kubectl set image deployments/worker-deployment worker=dev942/multi-worker:$SHA
#
