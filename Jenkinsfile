pipeline {
  agent any
  stages {
    stage('Dockerbuild') {
      steps {
        sh 'docker build -f Dockerfile.alpine .'
      }
    }

  }
}