module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down_reward_store {
    struct RewardStoredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_stored: u64,
        sender: address,
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock, arg7: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg7);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg5);
        let v0 = 0x2::coin::into_balance<T3>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T3>(arg2, arg3, arg4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::obligation_key_mut<T0, T1, T2>(arg1), arg5, arg6, arg8));
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::store_wind_down_reward<T0, T1, T2, T3>(arg1, v0);
        let v1 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1),
            reward_type  : 0x1::type_name::get<T3>(),
            amount       : 0x2::balance::value<T3>(&v0),
            total_stored : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg1),
            sender       : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<RewardStoredEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

