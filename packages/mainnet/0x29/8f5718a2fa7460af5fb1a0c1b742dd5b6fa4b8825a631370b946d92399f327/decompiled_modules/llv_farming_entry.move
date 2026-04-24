module 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_farming_entry {
    public entry fun add_farming_reward_config<T0, T1, T2>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg4: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::verify_pool_admin(arg2, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::id<T0, T1>(arg1));
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::add_reward_config<T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun claim_farming_reward<T0, T1>(arg0: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg1: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T0>, arg2: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
        };
    }

    public entry fun create_llv_farming_pool<T0, T1>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg4: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::verify_pool_admin(arg2, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::id<T0, T1>(arg1));
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::create_lend_pool<T1>(arg3, 0x2::object::id_address<0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>>(arg1), arg4);
    }

    public entry fun fund_farming_reward_bank<T0, T1, T2>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg4: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T1>, arg5: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::RewardBank<T2>, arg6: 0x2::coin::Coin<T2>, arg7: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::verify_pool_admin(arg2, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::id<T0, T1>(arg1));
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::fund_reward_bank<T1, T2>(arg3, arg4, arg5, arg6, arg7);
    }

    public fun get_claimable_rewards<T0>(arg0: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::ClaimableReward> {
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::get_claimable_rewards<T0>(arg0, arg1, arg2)
    }

    public fun get_reward_bank_reserve<T0>(arg0: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::RewardBank<T0>) : u64 {
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::reward_bank_reserve<T0>(arg0)
    }

    public entry fun set_farming_boost<T0, T1>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg4: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T1>, arg5: address, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::verify_pool_admin(arg2, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::id<T0, T1>(arg1));
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::set_boost<T1>(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun set_farming_reward_config<T0, T1, T2>(arg0: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVGlobal, arg1: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::LLVPool<T0, T1>, arg2: &0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::LLVPoolAdminCap, arg3: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg4: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T1>, arg5: &0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::RewardBank<T2>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::assert_version(arg0);
        0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_admin::verify_pool_admin(arg2, 0x298f5718a2fa7460af5fb1a0c1b742dd5b6fa4b8825a631370b946d92399f327::llv_pool::id<T0, T1>(arg1));
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::set_reward_config<T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun stake_after_deposit<T0>(arg0: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg1: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_for_withdraw<T0>(arg0: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Farming, arg1: &mut 0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8479eab1f01c69a513e3f7b8e1f0f3399e0f61fd1a23ebbc662695534ac9eef0::farming::unstake<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

