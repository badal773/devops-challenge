# SimpleTimeService: The Cloud Clock That Knows Your IP!


## Getting Started

1. **Clone this repo:**
   ```sh
   git clone https://github.com/badal773/devops-challenge.git
   cd devops-challenge
   ```

Welcome! This project is a fun, cloud-powered way to find out the current time and your own IP address. It's like a friendly clock that also knows where you are (but not in a creepy way).

---

## Task 1: Minimalist App & Docker (a.k.a. "What time is it?")

**Goal:** Build a tiny web app that tells you the current time and your IP address. No ads, no cookies, just the facts (and a little fun).

### How to run locally (or instantly in Docker!)

1. **Go to the app folder:**
   ```sh
   cd app
   ```
2. a. **Run instantly from DockerHub (no build needed!):**
   ```sh
   docker pull badal773/simpletimeservice:main
   docker run -p 8080:8080 badal773/simpletimeservice:main
   ```
   Open [http://localhost:8080](http://localhost:8080) in your browser and watch the magic happen! ✨
   _No need to build locally—just run it straight from the cloud!_

   <details>
   <summary>b. Build the Docker image yourself (if you want to tinker or test changes)</summary>

   ```sh
   docker build -t simpletimeservice .
   docker run -p 8080:8080 simpletimeservice
   ```
   (Open http://localhost:8080 in your browser)
   </details>

3. **See the magic:**
   - You'll get a JSON with the current time and your IP. (If you see the time, congrats! If you see your IP, don't panic—it's just your computer saying hi.)

---

## Task 2: Cloud & Terraform (a.k.a. "Send my clock to the clouds!")

**Goal:** Deploy the app to AWS using Terraform, Kubernetes (EKS), and all the cool cloud stuff. (No umbrella needed.)

### How to deploy to the cloud (no tech degree required):

1. **Go to the terraform folder:**
   ```sh
   cd terraform
   ```
2. **Install the tools:**
   - [Terraform](https://developer.hashicorp.com/terraform/downloads)
   - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/)
3. **Log in to AWS:**
   - Run: `aws configure`
   - Enter your AWS access keys (ask your friendly IT wizard if you don’t have them—or someone else with the keys to the cloud kingdom).
   - Your AWS user needs superhero powers: able to create VPCs, EKS clusters, IAM roles, EC2 instances, and load balancers in a single bound! (Admin is easiest, but as Uncle Ben said, "with great power comes great responsibility"—so at least give yourself EC2, EKS, IAM, and ELB admin rights. No villain origin stories, please.)
4. **Deploy the infrastructure:**
   - Initialize Terraform:
     ```sh
     terraform init
     ```
   - See what will happen (optional, but recommended!):
     ```sh
     terraform plan
     ```
   - Actually make it happen:
     Run:
     ```sh
     terraform apply
     ```
     (Say 'yes' when asked, unless you don't like fun. Or use `terraform apply --auto-approve` to skip the prompt!)
5. **Find your app's URL:**
   - After a few minutes, Terraform will show you a Load Balancer URL. Open it in your browser. Voilà! Time and IP, just for you.

### How to clean up (so you don't get a surprise bill):
Run:
```sh
terraform destroy
```
(Say 'yes' again, or use `terraform destroy --auto-approve` to skip the prompt. Unless you want to keep paying AWS for your new clock!)

---

## Extra Credit: Advanced DevOps Goodies

### 1. Remote Terraform State (S3 & DynamoDB)
This project supports remote state for Terraform! To enable it, add the following to your `terraform/main.tf`:
```hcl
terraform {
  backend "s3" {
    bucket         = "<your-s3-bucket-name>"
    key            = "devops-challenge/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "<your-dynamodb-table-name>"
    encrypt        = true
  }
}
```
- Create the S3 bucket and DynamoDB table before running `terraform init`.
- This keeps your state safe, shared, and locked!

### 2. CI/CD Pipeline
- The repo includes a GitHub Actions workflow that:
  - Builds and pushes the Docker image to DockerHub
  - Runs `terraform plan` and `terraform apply` (if TF_STATE_REMOTE is enabled)
- See [`.github/workflows/docker-build-and-update-k8s.yaml`](.github/workflows/docker-build-and-update-k8s.yaml) for details.

---

## FAQ (Frequently Amused Questions)

**Q: Is this secure?**
A: As secure as a clock can be! No personal data is stored. Just don't share your AWS keys with strangers.

**Q: Can I break it?**
A: Only if you try really, really hard. But if you do, that's a learning experience!

**Q: Why does this exist?**
A: To show off DevOps skills, and to make you smile.

---

Made with ☁️, ☕, and a little bit of laughter.
