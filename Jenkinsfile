pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "arsengalai/hello-world-task:latest"
        DOCKER_CREDS = credentials('dockerhub-creds') 
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo 'Building image...'
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Push to Docker Registry') {
            steps {
                echo 'Pushing image...'
                sh 'echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin'
                sh 'docker push ${DOCKER_IMAGE}'
            }
        }

        stage('Ansible: Check Docker') {
            steps {
                echo 'Checking Docker on workers...'
                sh 'ansible-playbook -i ansible/inventory.ini ansible/1-check-docker.yml'
            }
        }

        stage('Ansible: Check Swarm') {
            steps {
                echo 'Checking Docker Swarm...'
                sh 'ansible-playbook -i ansible/inventory.ini ansible/2-check-swarm.yml'
            }
        }

        stage('Ansible: Deploy Image') {
            steps {
                echo 'Deploying to Swarm...'
                sh 'ansible-playbook -i ansible/inventory.ini ansible/3-deploy.yml -e "target_image=${DOCKER_IMAGE}"'
            }
        }
    }
}
