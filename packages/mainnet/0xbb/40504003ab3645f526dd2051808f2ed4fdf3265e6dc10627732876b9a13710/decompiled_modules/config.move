module 0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::config {
    struct Config has drop, store {
        signers: vector<address>,
    }

    public fun new(arg0: vector<address>) : Config {
        Config{signers: arg0}
    }

    public fun set_signers(arg0: &mut Config, arg1: vector<address>) {
        arg0.signers = arg1;
    }

    public fun signers(arg0: &Config) : &vector<address> {
        &arg0.signers
    }

    // decompiled from Move bytecode v6
}

