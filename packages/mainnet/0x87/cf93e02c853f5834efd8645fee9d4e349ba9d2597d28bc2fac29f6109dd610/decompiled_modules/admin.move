module 0x87cf93e02c853f5834efd8645fee9d4e349ba9d2597d28bc2fac29f6109dd610::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x87cf93e02c853f5834efd8645fee9d4e349ba9d2597d28bc2fac29f6109dd610::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

