module 0xbdcb697aacef619aad35318d9645c0b7c8a4da958d3489e6ee6088e9fd215a70::g {
    public fun check_a1(arg0: u128, arg1: u256, arg2: bool) {
        if (arg2) {
            assert!((arg0 as u256) << 32 >= arg1, 101);
        } else {
            assert!((arg0 as u256) << 32 <= arg1, 101);
        };
    }

    public fun check_sqrt_x64(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    // decompiled from Move bytecode v7
}

