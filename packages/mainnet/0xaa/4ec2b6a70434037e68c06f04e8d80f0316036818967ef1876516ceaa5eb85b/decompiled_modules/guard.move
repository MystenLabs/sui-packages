module 0xaa4ec2b6a70434037e68c06f04e8d80f0316036818967ef1876516ceaa5eb85b::guard {
    public fun assert_ge(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

