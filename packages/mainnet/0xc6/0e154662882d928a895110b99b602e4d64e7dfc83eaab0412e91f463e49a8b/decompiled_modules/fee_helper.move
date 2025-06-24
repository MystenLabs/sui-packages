module 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::fee_helper {
    public fun get_composition_fee(arg0: u128, arg1: u128) : u128 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg1 as u256);
        (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_down((arg0 as u256), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_down(v0, v0 + 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::precision(), 1), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::squared_precision()) as u128)
    }

    public fun get_fee_amount(arg0: u128, arg1: u128) : u128 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg1 as u256);
        let v1 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::precision();
        if (v0 >= v1) {
            abort 500
        };
        (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_up((arg0 as u256), v0, v1 - v0) as u128)
    }

    public fun get_fee_amount_from(arg0: u128, arg1: u128) : u128 {
        verify_fee(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256);
        let v1 = 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_up(v0, (arg1 as u256), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::precision());
        if (v1 > v0) {
            arg0
        } else {
            (v1 as u128)
        }
    }

    public fun get_protocol_fee_amount(arg0: u128, arg1: u128) : u128 {
        verify_protocol_share(arg1);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math::mul_div_round_down((arg0 as u256), (arg1 as u256), 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::basis_point_max()) as u128)
    }

    public fun verify_fee(arg0: u128) {
        assert!((arg0 as u256) <= 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::max_fee(), 500);
    }

    public fun verify_protocol_share(arg0: u128) {
        assert!((arg0 as u256) <= 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::constants::max_protocol_share(), 501);
    }

    // decompiled from Move bytecode v6
}

