module 0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

