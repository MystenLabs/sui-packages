module 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::mul_u128((arg1 as u128), (0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::add_u64(arg1, 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::precision()) as u128)), (0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::squared_precision() as u128))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::precision(), 502);
        0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::u128_to_u64(0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::sub_u64(0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::precision(), 502);
        0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::u128_to_u64(0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::q64x64::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::safe_math::mul_div_u64(arg0, arg1, 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::basis_point_max())
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xff921c4fcf7abd1bff1b2e5fdb1f463e88cb4863a4261948a3cc8bb227ca697e::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

