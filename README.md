
# SimpleTimeService: The Time-Telling Cloud App (with a Smile!)

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

### How to run locally (for the curious or the hungry-for-time):

1. **Go to the app folder:**
   ```sh
   cd app
   ```
2. **Build the Docker image:**
   ```sh
   docker build -t simpletimeservice .
   ```
3. **Run the app:**
   ```sh
   docker run -p 8080:8080 simpletimeservice
   # Open http://localhost:8080 in your browser
   ```
4. **See the magic:**
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
   ```sh
   terraform init
   terraform apply
   # Say 'yes' when asked (unless you don't like fun)
   ```
5. **Find your app's URL:**
   - After a few minutes, Terraform will show you a Load Balancer URL. Open it in your browser. Voilà! Time and IP, just for you.

### How to clean up (so you don't get a surprise bill):
```sh
terraform destroy
# Say 'yes' again (unless you want to keep paying AWS for your new clock)
```

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
