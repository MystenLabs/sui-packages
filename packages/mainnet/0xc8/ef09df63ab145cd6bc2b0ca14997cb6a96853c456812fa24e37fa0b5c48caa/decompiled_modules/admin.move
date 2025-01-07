module 0xc8ef09df63ab145cd6bc2b0ca14997cb6a96853c456812fa24e37fa0b5c48caa::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xc8ef09df63ab145cd6bc2b0ca14997cb6a96853c456812fa24e37fa0b5c48caa::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

