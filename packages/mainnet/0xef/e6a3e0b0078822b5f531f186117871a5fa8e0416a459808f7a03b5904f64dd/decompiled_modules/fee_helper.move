module 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::constants::precision();
        0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_u128((arg1 as u128), (0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::add_u64(arg1, v0) as u128)), 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_u128((v0 as u128), (v0 as u128)))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::u128_to_u64(0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::div_round_up_u128(0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_u128((arg0 as u128), (arg1 as u128)), (0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::sub_u64(0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::min(0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::div_round_up_u128(0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_u128((arg0 as u128), (arg1 as u128)), (0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::constants::precision() as u128)), (arg0 as u128)) as u64)
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::safe_math::mul_div_u64(arg0, arg1, 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::constants::basis_point_max())
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xefe6a3e0b0078822b5f531f186117871a5fa8e0416a459808f7a03b5904f64dd::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

