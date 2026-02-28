let 
	public-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBO6kgIimAZKHOREPrGc2d0Yj8zQpE5cwDrE2256ik4";
in {
	"secret1.age".publicKeys = [public-key];
}
