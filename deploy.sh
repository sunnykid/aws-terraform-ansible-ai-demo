#!/bin/bash
set -e

# Terraform 적용
cd terraform
terraform init
terraform apply -auto-approve
terraform output -json > tf_output.json
cd ..

# Ansible 실행
ansible-playbook -i ansible/inventory.yml ansible/playbook.yml

# 테스트: App 서버에서 AI API 호출
ansible app -i ansible/inventory.yml -m shell -a "python3 /home/ec2-user/test_ai.py"
