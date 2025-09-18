module 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::fee_helper {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::precision();
        0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_div_u128_to_u64((arg0 as u128), 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_u128((arg1 as u128), (0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::add_u64(arg1, v0) as u128)), 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_u128((v0 as u128), (v0 as u128)))
    }

    public fun get_fee_amount_exclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::precision(), 502);
        0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::u128_to_u64(0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::sub_u64(0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::precision(), arg1) as u128)))
    }

    public fun get_fee_amount_inclusive(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::precision(), 502);
        0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::u128_to_u64(0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_div_round_up_u128((arg0 as u128), (arg1 as u128), (0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::precision() as u128)))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u64) : u64 {
        0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::safe_math::mul_div_u64(arg0, arg1, 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::basis_point_max())
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xb7b5743457cfa1f221ccd18ae30527023629286b4fea5e97f0214fc725c4252::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

