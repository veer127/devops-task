# DevOps Task – CI/CD Pipeline with Docker & Jenkins

## 1\. Architecture Diagram 🏗️

This diagram visualizes the continuous integration and continuous deployment (CI/CD) pipeline for our application.

```
    +-----------+          +----------+          +------------+          +----------------+
    |  GitHub   |   --->   |  Jenkins |   --->   |  Docker    |   --->   | AWS EC2 / ECS  |
    +-----------+          +----------+          +------------+          +----------------+
                                 |
                                 v
                         +----------------+
                         |  CloudWatch    |
                         +----------------+
```

The **flow** is as follows: GitHub → Jenkins → Docker → AWS EC2 → CloudWatch.

-----

## 2\. Setup Instructions ⚙️

### Prerequisites

Before you begin, ensure you have the following ready:

  * An **AWS EC2 instance** (Ubuntu 20.04 or a newer version)
  * **Jenkins** installed on your EC2 instance
  * **Docker** installed on your EC2 instance
  * A **GitHub account** and a repository for your project
  * A **DockerHub account**

### Steps to Run the Application

1.  **Clone the repository**

    ```bash
    git clone https://github.com/your-username/devops-task.git
    cd devops-task
    ```

2.  **Install dependencies**

    ```bash
    npm install
    ```

3.  **Build the Docker image**

    ```bash
    docker build -t veer45/devops-task:latest .
    ```

4.  **Run the Docker container**

    ```bash
    docker run -d -p 3000:3000 --name devops-task veer45/devops-task:latest
    ```

5.  **Verify the application**
    Open a web browser and navigate to `http://107.21.130.176:3000`. You should see the **Swayatt logo** served by the Express.js application, confirming it's running correctly.

-----

## 3\. Jenkins CI/CD Pipeline Flow 🚀

The `Jenkinsfile` defines a series of **pipeline stages** that automate the build, test, and deployment process every time a change is pushed to the GitHub repository.

### Pipeline Stages

  * **Checkout**: Pulls the latest code from the GitHub repository.
  * **Install & Test**: Installs Node.js dependencies using `npm install` and then runs tests with `npm test`. If no tests are configured, this stage will simply be skipped.
  * **Dockerize**: Builds the Docker image based on the instructions in the `Dockerfile`.
  * **Push to DockerHub**: Pushes the newly built image to DockerHub. This is done securely using **Jenkins credentials** to store your DockerHub login details.
  * **Deploy**: Stops any running container with the same name (`devops-task`) to prevent conflicts and then deploys the new container on the EC2 instance, exposing port 3000.

-----

## 4\. Monitoring & Logging 📊

This pipeline integrates with **AWS CloudWatch** to provide real-time monitoring and logging for the deployed application.

  * **Logs**: The **CloudWatch Agent** collects logs from the Docker container and sends them to a log group named `devops-task-app`. To view the logs, go to the AWS Console, navigate to CloudWatch → Logs → Log groups → `devops-task-app`. Click on a log stream (which is named after the container ID) to see the output, such as:
    ```
    2025-09-13T06:53:23Z info: Server running on http://localhost:3000
    2025-09-13T06:55:10Z info: GET / 200
    ```
  * **Metrics**: Key metrics like **CPU, Memory, and Disk usage** for the EC2 instance are available under CloudWatch → Metrics → EC2. You can use these to track the performance and health of your server.

-----

## 5\. Project Structure 📁

```
├── app.js               # Main server file
├── package.json         # Project dependencies and scripts
├── package-lock.json    # Package lock file
├── Dockerfile           # Docker image instructions
├── .dockerignore        # Specifies files and directories to ignore in the Docker build context
├── Jenkinsfile          # Jenkins pipeline definition
├── README.md            # This file
└── logoswayatt.png      # Logo image served by the application
```

-----

## 6\. Notes 📝

  * The `.dockerignore` file is used to prevent unnecessary files like `node_modules` from being added to the Docker image, which helps keep the image size small and the build process fast.
  * The Jenkins credentials feature is crucial for securely handling sensitive information like your DockerHub login.
  * The pipeline supports **re-deployment without downtime** by stopping the old container before starting the new one, ensuring a clean and reliable update.
  * CloudWatch logs are invaluable for **debugging and monitoring** the health of the application in a production environment.

## 7\. Challenges & Improvements

### Challenges Faced
- Docker permissions on EC2 preventing non-root usage.
- Jenkins configuration for Node.js and Docker tools.
- CloudWatch agent credential setup issues on EC2.
- Deciding between AWS ECS, Google Cloud Run, or Kubernetes for deployment.

### Possible Improvements
- Deploy using **AWS ECS Fargate**, **Google Cloud Run**, or **Kubernetes (EKS/GKE)** for better scalability.
- Implement **Infrastructure as Code (IaC)** using **Terraform** to automate cloud resources, including CloudWatch agent installation.
- Add automated **Node.js testing** in Jenkins pipeline.
- Optimize Docker images for smaller size and faster builds.
- Configure monitoring dashboards and alerts for application metrics.

