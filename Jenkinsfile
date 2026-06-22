pipeline {

agent any





tools {

    maven 'Maven-3.8.4'

}

environment {

    APP_NAME = "demo-app"

    COMPANY = "Company"

} 



parameters {

    choice(

        name: 'ENVIRONMENT',

        choices: ['DEV', 'QA', 'PROD'],

        description: 'Select Environment'

    )

}



stages {



    stage('Show Environment') {

        steps {

            echo "Selected Environment: ${params.ENVIRONMENT}"

        }

    }

stage('Environment Info') {

    steps {

        echo "Application: ${APP_NAME}"

        echo "Organization: ${COMPANY}"

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



    stage('Approval') {

        steps {

            input 'Approve deployment?'

        }

    }


    stage('SonarQube Analysis') {
   	 steps {
        	script {
           	 def scannerHome = tool 'SonarScanner'

           	 withSonarQubeEnv('SonarQube') {
               	 sh """
               	 ${scannerHome}/bin/sonar-scanner \
               	 -Dsonar.projectKey=demo-app \
               	 -Dsonar.projectName=demo-app \
               	 -Dsonar.sources=src \
               	 -Dsonar.java.binaries=target/classes
               	 """
        	    }
       	 }
    	}
	}
   stage('Deploy') {

    steps {

        script {



            if (params.ENVIRONMENT == "DEV") {

                echo "Deploying to Development Server"

            }



            else if (params.ENVIRONMENT == "QA") {

                echo "Deploying to QA Server"

            }



            else {

                echo "Deploying to Production Server"

            }



        }

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

