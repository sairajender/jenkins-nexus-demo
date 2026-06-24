pipeline {
agent any

tools {
    maven 'Maven'
}

environment {
    IMAGE_NAME = "sairajender/demo-app"
    IMAGE_TAG = "${BUILD_NUMBER}"
}

stages {

    stage('Build') {
        steps {
            sh 'mvn clean package'
        }
    }

    stage('SonarQube Analysis') {
        steps {
            withSonarQubeEnv('SonarQube') {
                sh '''
                mvn sonar:sonar \
                -Dsonar.projectKey=demo-app \
                -Dsonar.host.url=http://3.82.243.130:9000 \
                -Dsonar.login=sqp_48f828fcf54460853c0935e23962abb9607e9de2
                '''
            }
        }
    }

    stage('Quality Gate') {
    steps {
        script {
            timeout(time: 10, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
            }
        }
    }
}



    stage('Build Docker Image') {
        steps {
            sh '''
            docker build -t $IMAGE_NAME:$IMAGE_TAG .
            '''
        }
    }

    stage('Push To Docker Hub') {
        steps {
            withCredentials([
                usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )
            ]) {
                sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

                docker push $IMAGE_NAME:$IMAGE_TAG

                docker logout
                '''
            }
        }
    }
	stage('Deploy Container') {

   	 steps {

       	 sh '''
      	  docker stop demo-container || true
      	  docker rm demo-container || true

        docker run -d \
        --name demo-container \
        sairajender/demo-app:${BUILD_NUMBER}
        '''
    }
}
}

post {
    success {
        echo 'Docker Image Successfully Pushed'
    }

    failure {
        echo 'Pipeline Failed'
    }
}

}
