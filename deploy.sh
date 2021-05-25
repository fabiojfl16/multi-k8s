docker build -t fabiojfl/multi-client:latest -t fabiojfl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fabiojfl/multi-server:latest -t fabiojfl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fabiojfl/multi-worker:latest -t fabiojfl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fabiojfl/multi-client:latest
docker push fabiojfl/multi-server:latest
docker push fabiojfl/multi-worker:latest

docker push fabiojfl/multi-client:$SHA
docker push fabiojfl/multi-server:$SHA
docker push fabiojfl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=fabiojfl/multi-server:$SHA
kubectl set image deployments/client-deployment client=fabiojfl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fabiojfl/multi-worker:$SHA