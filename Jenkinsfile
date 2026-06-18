pipeline {
    agent any

    tools {
        maven 'Maven-3.8.4'
    }
    parameters {
        choice(
         name: 'ENVIRONMENT',
         choices: ['DEV','QA','PROD'],
         description: 'Select Environment'
    )
}
    stages {
	stage('Show Environment') {
   	 steps {
        	echo "Selected Environment: ${params.ENVIRONMENT}"
    	    }
	}

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/sairajender/jenkins-nexus-demo.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Deploy To Nexus') {
            steps {
                sh 'mvn deploy'
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful'
        }

        failure {
            echo 'Deployment Failed'
        }
    }
}
