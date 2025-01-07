module 0x26aa5d23c4f9b485d421a2da7f19381531012ac5d0f5a10b04326c36d54a4c46::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x26aa5d23c4f9b485d421a2da7f19381531012ac5d0f5a10b04326c36d54a4c46::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

