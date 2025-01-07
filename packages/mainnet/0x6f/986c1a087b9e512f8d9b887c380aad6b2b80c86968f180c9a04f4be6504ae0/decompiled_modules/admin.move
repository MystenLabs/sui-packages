module 0x6f986c1a087b9e512f8d9b887c380aad6b2b80c86968f180c9a04f4be6504ae0::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x6f986c1a087b9e512f8d9b887c380aad6b2b80c86968f180c9a04f4be6504ae0::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

