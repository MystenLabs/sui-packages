module 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::mul_u128((arg1 as u128), (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::add_u64(arg1, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::precision()) as u128)), (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::squared_precision() as u128))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::precision(), 502);
        0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::u128_to_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::sub_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::precision(), 502);
        0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::u128_to_u64(0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::safe_math::mul_div_u64(arg0, arg1, 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::basis_point_max())
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xa1476d3120e224016541f8495c239ac18131b27465a3f2a089d6f038b8cc4786::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

