module 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe {
    public fun safe128(arg0: u256) : u128 {
        assert!(arg0 >> 128 == 0, 13906834264537956357);
        (arg0 as u128)
    }

    public fun safe32(arg0: u256) : u32 {
        assert!(arg0 >> 32 == 0, 13906834221588021249);
        (arg0 as u32)
    }

    public fun safe64(arg0: u256) : u64 {
        assert!(arg0 >> 64 == 0, 13906834243062988803);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

