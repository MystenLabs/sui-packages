module 0xe8bf154a953c8c4961276939cac2facac48b705c84c0e72323bd6045ad7aec12::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xe8bf154a953c8c4961276939cac2facac48b705c84c0e72323bd6045ad7aec12::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

