module 0x1c8113fbcc25568ed5f37abade86a61451b05273c19e58b283f9dda40899cb1d::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x1c8113fbcc25568ed5f37abade86a61451b05273c19e58b283f9dda40899cb1d::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

