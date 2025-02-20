module 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::incentive_rewards {
    struct RewardFactors has drop {
        dummy_field: bool,
    }

    struct RewardFactor has store {
        coin_type: 0x1::type_name::TypeName,
        reward_factor: 0x1::fixed_point32::FixedPoint32,
    }

    public(friend) fun init_table(arg0: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<RewardFactors, 0x1::type_name::TypeName, RewardFactor> {
        let v0 = RewardFactors{dummy_field: false};
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::new<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v0, false, arg0)
    }

    public fun reward_factor(arg0: &RewardFactor) : 0x1::fixed_point32::FixedPoint32 {
        arg0.reward_factor
    }

    public(friend) fun set_reward_factor<T0>(arg0: &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<RewardFactors, 0x1::type_name::TypeName, RewardFactor>, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::contains<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(arg0, v0)) {
            let v1 = RewardFactor{
                coin_type     : v0,
                reward_factor : 0x1::fixed_point32::create_from_rational(arg1, arg2),
            };
            let v2 = RewardFactors{dummy_field: false};
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::add<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v2, arg0, v0, v1);
        } else {
            let v3 = RewardFactors{dummy_field: false};
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow_mut<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v3, arg0, v0).reward_factor = 0x1::fixed_point32::create_from_rational(arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

