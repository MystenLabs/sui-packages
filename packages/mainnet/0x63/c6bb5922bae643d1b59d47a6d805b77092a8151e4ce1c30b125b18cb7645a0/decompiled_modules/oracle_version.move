module 0x63c6bb5922bae643d1b59d47a6d805b77092a8151e4ce1c30b125b18cb7645a0::oracle_version {
    public fun next_version() : u64 {
        0x63c6bb5922bae643d1b59d47a6d805b77092a8151e4ce1c30b125b18cb7645a0::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x63c6bb5922bae643d1b59d47a6d805b77092a8151e4ce1c30b125b18cb7645a0::oracle_constants::version(), 0x63c6bb5922bae643d1b59d47a6d805b77092a8151e4ce1c30b125b18cb7645a0::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x63c6bb5922bae643d1b59d47a6d805b77092a8151e4ce1c30b125b18cb7645a0::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

