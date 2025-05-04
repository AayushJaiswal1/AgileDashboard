pipeline {
    agent any

    environment {
        IMAGE_NAME = "agile-dashboard"
        CONTAINER_NAME = "flask-app"
        DOCKERHUB_USERNAME = "aayushaj112"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/AayushJaiswal1/AgileDashboard.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run App Container (Local Test)') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}
                sleep 5
                curl -f http://localhost:5000 || exit 1
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_TOKEN')]) {
                    sh """
                    echo "${DOCKER_TOKEN}" | docker login -u ${DOCKERHUB_USERNAME} --password-stdin
                    docker tag ${IMAGE_NAME} ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                    docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d -p 80:5000 --name ${CONTAINER_NAME} ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                """
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
