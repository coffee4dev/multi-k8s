docker build -t coffee4whale/multi-client:latest -t coffee4whale/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t coffee4whale/multi-server:latest -t coffee4whale/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t coffee4whale/multi-worker:latest -t coffee4whale/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push coffee4whale/multi-client:latest
docker push coffee4whale/multi-server:latest
docker push coffee4whale/multi-worker:latest

docker push coffee4whale/multi-client:$SHA
docker push coffee4whale/multi-server:$SHA
docker push coffee4whale/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=coffee4whale/multi-server:$SHA
kubectl set image deployments/client-deployment client=coffee4whale/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=coffee4whale/multi-worker:$SHA
