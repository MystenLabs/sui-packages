module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::incentive_rewards {
    struct RewardFactors has drop {
        dummy_field: bool,
    }

    struct RewardFactor has store {
        coin_type: 0x1::type_name::TypeName,
        reward_factor: 0x1::fixed_point32::FixedPoint32,
    }

    public(friend) fun init_table(arg0: &mut 0x2::tx_context::TxContext) : 0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::WitTable<RewardFactors, 0x1::type_name::TypeName, RewardFactor> {
        let v0 = RewardFactors{dummy_field: false};
        0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::new<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v0, false, arg0)
    }

    public fun reward_factor(arg0: &RewardFactor) : 0x1::fixed_point32::FixedPoint32 {
        arg0.reward_factor
    }

    public(friend) fun set_reward_factor<T0>(arg0: &mut 0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::WitTable<RewardFactors, 0x1::type_name::TypeName, RewardFactor>, arg1: u64, arg2: u64) {
        let v0 = 0x1::fixed_point32::create_from_rational(arg1, arg2);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::contains<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(arg0, v1)) {
            let v2 = RewardFactor{
                coin_type     : v1,
                reward_factor : v0,
            };
            let v3 = RewardFactors{dummy_field: false};
            0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::add<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v3, arg0, v1, v2);
        };
        let v4 = RewardFactors{dummy_field: false};
        0x36cd7549398c4cfcb7d5a9c3ce94adffdf6749869762dbae773764ad3b4314fc::wit_table::borrow_mut<RewardFactors, 0x1::type_name::TypeName, RewardFactor>(v4, arg0, v1).reward_factor = v0;
    }

    // decompiled from Move bytecode v6
}

