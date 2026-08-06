module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down_reward_access {
    struct RewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        harvest_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        harvest_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        sender: address,
    }

    public fun claim_stored_reward<T0, T1, T2, T3>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T3>(),
            amount         : 0x2::balance::value<T3>(&v0),
            recipient      : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v0, arg2), v1);
    }

    public fun settle_stored_reward_a<T0: store, T1, T2>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg2);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_take_wind_down_reward<T0, T1, T2, T0>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_join_settled_reward_a<T0, T1, T2>(arg0, arg1, v0, arg3);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            input_amount   : v1,
            output_amount  : v1,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun stored_reward_balance<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>) : u64 {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg0)
    }

    // decompiled from Move bytecode v7
}

