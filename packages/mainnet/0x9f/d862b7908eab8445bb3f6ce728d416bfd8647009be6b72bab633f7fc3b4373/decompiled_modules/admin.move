module 0x9fd862b7908eab8445bb3f6ce728d416bfd8647009be6b72bab633f7fc3b4373::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x9fd862b7908eab8445bb3f6ce728d416bfd8647009be6b72bab633f7fc3b4373::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

