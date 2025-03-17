
echo "setup an actas sa and a user's permission"

kubectl apply -f .

echo "get token from sa and set the config"

TOKEN=$(kubectl create token actas -n default)

echo "sa actas user to get node will fail since sa does not have the permission"

curl -H"Authorization:Bearer $TOKEN" -H"Impersonate-User:bob" -k https://localhost:6443/api/v1/nodes

echo "sa actas user to get service will fail since the user does not have the permission"

curl -H"Authorization:Bearer $TOKEN" -H"Impersonate-User:bob" -k https://localhost:6443/api/v1/services

echo "sa actas user to get pods succeeds since both have the permission"

curl -H"Authorization:Bearer $TOKEN" -H"Impersonate-User:bob" -k https://localhost:6443/api/v1/pods
