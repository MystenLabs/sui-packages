module 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

