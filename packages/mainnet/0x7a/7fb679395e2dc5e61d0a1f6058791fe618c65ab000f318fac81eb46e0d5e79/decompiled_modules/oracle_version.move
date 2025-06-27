module 0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle_version {
    public fun next_version() : u64 {
        0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle_constants::version(), 0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x7a7fb679395e2dc5e61d0a1f6058791fe618c65ab000f318fac81eb46e0d5e79::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

