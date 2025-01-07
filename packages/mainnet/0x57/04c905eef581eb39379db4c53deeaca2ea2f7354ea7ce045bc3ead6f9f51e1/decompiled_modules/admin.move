module 0x5704c905eef581eb39379db4c53deeaca2ea2f7354ea7ce045bc3ead6f9f51e1::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x5704c905eef581eb39379db4c53deeaca2ea2f7354ea7ce045bc3ead6f9f51e1::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

