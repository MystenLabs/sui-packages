module 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe {
    public fun safe128(arg0: u256) : u128 {
        assert!(arg0 >> 128 == 0, 9223372127049351173);
        (arg0 as u128)
    }

    public fun safe32(arg0: u256) : u32 {
        assert!(arg0 >> 32 == 0, 9223372084099416065);
        (arg0 as u32)
    }

    public fun safe64(arg0: u256) : u64 {
        assert!(arg0 >> 64 == 0, 9223372105574383619);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

