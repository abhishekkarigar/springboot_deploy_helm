
podTemplate(nodeSelector: 'kubernetes.io/hostname=minikube',label: 'mypod', containers: [
    containerTemplate(name: 'git', image: 'alpine/git', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'maven', image: 'maven:3.3.9-jdk-8-alpine', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
  ) {
    node('mypod') {
        stage('Check running containers') {
            container('docker') {
                // example to show you can run docker commands when you mount the socket
                sh 'hostname'
                sh 'hostname -i'
                sh 'docker ps'
            }
        }
        
        stage('Clone repository') {
            container('git') {
                sh 'whoami'
                sh 'hostname -i'
                sh 'git clone https://github.com/abhishekkarigar/springboot_deploy_helm.git'
            }
        }

        stage('Maven Build') {
            container('maven') {
                dir('springboot_deploy_helm/') {
                    sh 'hostname'
                    sh 'hostname -i'
                    sh 'mvn clean install'
                }
            }
        }
    }
}

//pipeline {
//   agent any
//   stages {
//    stage('Checkout') {
//      steps {
//        script {
//           // The below will clone your repo and will be checked out to master branch by default.
//           git url: 'https://github.com/aakashsehgal/FMU.git'
//           // Do a ls -lart to view all the files are cloned. It will be clonned. This is just for you to be sure about it.
//           sh "ls -lart ./*" 
//           // List all branches in your repo. 
//           sh "git branch -a"
//           // Checkout to a specific branch in your repo.
//           sh "git checkout branchname"
//          }
//       }
//    }
//  }
//}
