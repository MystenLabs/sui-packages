module 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_discount {
    public fun apply_discount(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 <= 1000000000000000000, 18001);
        arg0 * (1000000000000000000 - arg1) / 1000000000000000000
    }

    public fun discount_rate_from_stake_position(arg0: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePool, arg1: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePosition, arg2: &0x2::clock::Clock, arg3: address) : u256 {
        0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::assert_position_owner(arg1, arg3);
        0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::assert_position_in_pool(arg0, arg1);
        discount_rate_from_weight(0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::current_vtaco_shares(arg1, arg2))
    }

    fun discount_rate_from_weight(arg0: u256) : u256 {
        if (arg0 < 1000000000000) {
            0
        } else if (arg0 < 5000000000000) {
            50000000000000000
        } else if (arg0 < 20000000000000) {
            100000000000000000
        } else if (arg0 < 50000000000000) {
            200000000000000000
        } else if (arg0 < 100000000000000) {
            300000000000000000
        } else if (arg0 < 500000000000000) {
            400000000000000000
        } else if (arg0 <= 1000000000000000) {
            500000000000000000
        } else {
            600000000000000000
        }
    }

    // decompiled from Move bytecode v6
}

