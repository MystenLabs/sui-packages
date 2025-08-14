module 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::constants::precision();
        0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_u128((arg1 as u128), (0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::add_u64(arg1, v0) as u128)), 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_u128((v0 as u128), (v0 as u128)))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::u128_to_u64(0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::div_round_up_u128(0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_u128((arg0 as u128), (arg1 as u128)), (0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::sub_u64(0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        (0x1::u128::min(0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::div_round_up_u128(0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_u128((arg0 as u128), (arg1 as u128)), (0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::constants::precision() as u128)), (arg0 as u128)) as u64)
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::safe_math::mul_div_u64(arg0, arg1, 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::constants::basis_point_max())
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xb1c826e995342b3e064c4110c33566ad01d0606337a53af714aa1d64667b8209::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

