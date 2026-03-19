module 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_farming_entry {
    public entry fun add_farming_reward_config<T0, T1, T2>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg4: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::verify_pool_admin(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::id<T0, T1>(arg1));
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::add_reward_config<T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun claim_farming_reward<T0, T1>(arg0: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg1: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T0>, arg2: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::RewardBank<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v0), 0x2::tx_context::sender(arg4));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v0);
        };
    }

    public entry fun create_llv_farming_pool<T0, T1>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg4: &mut 0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::verify_pool_admin(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::id<T0, T1>(arg1));
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::create_lend_pool<T1>(arg3, 0x2::object::id_address<0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>>(arg1), arg4);
    }

    public entry fun fund_farming_reward_bank<T0, T1, T2>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg4: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T1>, arg5: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::RewardBank<T2>, arg6: 0x2::coin::Coin<T2>, arg7: &0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::verify_pool_admin(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::id<T0, T1>(arg1));
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::fund_reward_bank<T1, T2>(arg3, arg4, arg5, arg6, arg7);
    }

    public fun get_claimable_rewards<T0>(arg0: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::ClaimableReward> {
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::get_claimable_rewards<T0>(arg0, arg1, arg2)
    }

    public entry fun set_farming_boost<T0, T1>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg4: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T1>, arg5: address, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::verify_pool_admin(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::id<T0, T1>(arg1));
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::set_boost<T1>(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun set_farming_reward_config<T0, T1, T2>(arg0: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVGlobal, arg1: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::LLVPool<T0, T1>, arg2: &0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::LLVPoolAdminCap, arg3: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg4: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T1>, arg5: &0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::RewardBank<T2>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::assert_version(arg0);
        0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_admin::verify_pool_admin(arg2, 0x25bbc3daad1803f05e0a400a9de2bc3ecf75c2d5e861aa77dc1d3c0d1969c799::llv_pool::id<T0, T1>(arg1));
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::set_reward_config<T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun stake_after_deposit<T0>(arg0: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg1: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::stake<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_for_withdraw<T0>(arg0: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Farming, arg1: &mut 0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::Pool<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x7018bee5f4190741b1f76d05bf2ed7e5f4f6a2fa2a1e1e4a62d67bf2a0278e54::farming::unstake<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

