module 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::app_version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    public fun is_compatible_version(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 1001);
    }

    // decompiled from Move bytecode v7
}

