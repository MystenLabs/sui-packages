module 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

