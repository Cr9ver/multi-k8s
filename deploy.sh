docker build -t cr9ver/multi-client:latest -t cr9ver/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cr9ver/multi-server:latest -t cr9ver/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cr9ver/multi-worker:latest -t cr9ver/multi-worker:$SHA -f ./server/Dockerfile ./worker
docker push cr9ver/multi-client:latest
docker push cr9ver/multi-server:latest
docker push cr9ver/multi-worker:latest


docker push cr9ver/multi-client:$SHA
docker push cr9ver/multi-server:$SHA
docker push cr9ver/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cr9ver/multi-server:$SHA
kubectl set image deployments/client-deployment client=cr9ver/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cr9ver/multi-worker:$SHA
