module 0x14baeffb178abdc47d8a1c947200aff1ac842569c39313c481b5aafccf996a0f::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x14baeffb178abdc47d8a1c947200aff1ac842569c39313c481b5aafccf996a0f::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

