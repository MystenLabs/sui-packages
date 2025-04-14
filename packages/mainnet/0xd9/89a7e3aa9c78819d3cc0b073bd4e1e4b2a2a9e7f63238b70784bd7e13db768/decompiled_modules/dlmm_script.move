module 0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_script {
    struct EventFetchBins has copy, drop, store {
        bins: vector<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::Bin>,
    }

    struct EventPairParams has copy, drop, store {
        params: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPairParameter,
    }

    struct EventPairLiquidity has copy, drop, store {
        shares: u64,
        liquidity: u256,
        x: u64,
        y: u64,
        bin_ids: vector<u32>,
        bin_x: vector<u64>,
        bin_y: vector<u64>,
    }

    struct EventPositionLiquidity has copy, drop, store {
        shares: u64,
        liquidity: u256,
        x_equivalent: u64,
        y_equivalent: u64,
        bin_ids: vector<u32>,
        bin_x_eq: vector<u64>,
        bin_y_eq: vector<u64>,
        bin_liquidity: vector<u256>,
    }

    struct EventEarnedFees has copy, drop, store {
        position_id: 0x2::object::ID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        fee_x: u64,
        fee_y: u64,
    }

    struct EventEarnedRewards has copy, drop, store {
        position_id: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct EventEarnedRewards2 has copy, drop, store {
        position_id: 0x2::object::ID,
        reward1: 0x1::type_name::TypeName,
        reward2: 0x1::type_name::TypeName,
        amount1: u64,
        amount2: u64,
    }

    struct EventEarnedRewards3 has copy, drop, store {
        position_id: 0x2::object::ID,
        reward1: 0x1::type_name::TypeName,
        reward2: 0x1::type_name::TypeName,
        reward3: 0x1::type_name::TypeName,
        amount1: u64,
        amount2: u64,
        amount3: u64,
    }

    struct EventPairRewardTypes has copy, drop, store {
        pair_id: 0x2::object::ID,
        tokens: vector<0x1::type_name::TypeName>,
    }

    public entry fun swap<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v1;
        let v4 = v0;
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public entry fun burn_position<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, &arg1, arg2, arg3);
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::burn_position<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut v5, v0);
        0x2::balance::join<T1>(&mut v4, v1);
        if (0x2::balance::value<T0>(&v5) == 0) {
            0x2::balance::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg3), 0x2::tx_context::sender(arg3));
        };
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun burn_position_reward1<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<T0>(&mut v6, v1);
        0x2::balance::join<T1>(&mut v5, v2);
        if (0x2::balance::value<T0>(&v6) == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), 0x2::tx_context::sender(arg4));
        };
        if (0x2::balance::value<T1>(&v5) == 0) {
            0x2::balance::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun burn_position_reward2<T0, T1, T2, T3>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v4, v5) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
        let v6 = v5;
        let v7 = v4;
        0x2::balance::join<T0>(&mut v7, v2);
        0x2::balance::join<T1>(&mut v6, v3);
        if (0x2::balance::value<T0>(&v7) == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), 0x2::tx_context::sender(arg4));
        };
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun burn_position_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T4>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v5, v6) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, v3);
        0x2::balance::join<T1>(&mut v7, v4);
        if (0x2::balance::value<T0>(&v8) == 0) {
            0x2::balance::destroy_zero<T0>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg4), 0x2::tx_context::sender(arg4));
        };
        if (0x2::balance::value<T1>(&v7) == 0) {
            0x2::balance::destroy_zero<T1>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun collect_fees<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    public entry fun collect_reward2<T0, T1, T2, T3>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
    }

    public entry fun collect_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
    }

    public entry fun create_pair<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>>(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::create_pair_by_preset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public entry fun create_pair_add_liquidity<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg1: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: vector<u32>, arg8: vector<u64>, arg9: vector<u64>, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::create_pair_by_preset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg12);
        let (_, v2) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::mint_by_amounts<T0, T1>(&mut v0, arg0, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position>(v2, arg10);
        0x2::transfer::public_share_object<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>>(v0);
    }

    public entry fun earned_fees<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_fees<T0, T1>(arg0, arg1);
        let v2 = EventEarnedFees{
            position_id : arg1,
            x           : 0x1::type_name::get<T0>(),
            y           : 0x1::type_name::get<T1>(),
            fee_x       : v0,
            fee_y       : v1,
        };
        0x2::event::emit<EventEarnedFees>(v2);
    }

    public entry fun earned_reward3<T0, T1, T2, T3, T4>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards3{
            position_id : arg1,
            reward1     : 0x1::type_name::get<T2>(),
            reward2     : 0x1::type_name::get<T3>(),
            reward3     : 0x1::type_name::get<T4>(),
            amount1     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
            amount2     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T3>(arg0, arg1, arg2),
            amount3     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T4>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards3>(v0);
    }

    public entry fun earned_rewards<T0, T1, T2>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards{
            position_id : arg1,
            reward      : 0x1::type_name::get<T2>(),
            amount      : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards>(v0);
    }

    public entry fun earned_rewards2<T0, T1, T2, T3>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards2{
            position_id : arg1,
            reward1     : 0x1::type_name::get<T2>(),
            reward2     : 0x1::type_name::get<T3>(),
            amount1     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
            amount2     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::earned_reward<T0, T1, T3>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards2>(v0);
    }

    public entry fun fetch_bins<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = EventFetchBins{bins: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::fetch_bins<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<EventFetchBins>(v0);
    }

    public entry fun fetch_pair_params<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = EventPairParams{params: *0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0)};
        0x2::event::emit<EventPairParams>(v0);
    }

    fun get_distribution_by_strategy(arg0: u8, arg1: u32, arg2: u32, arg3: u32) : (vector<u32>, vector<u256>) {
        let v0 = &arg0;
        if (*v0 == 1) {
            0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_weight_spot_balanced(arg1, arg2)
        } else if (*v0 == 2) {
            0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_weight_curve(arg1, arg2, arg3)
        } else {
            assert!(*v0 == 3, 0);
            0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_weight_bid_ask(arg1, arg2, arg3)
        }
    }

    public entry fun get_pair_rewarders<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::borrow_rewarders(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::rewarder_manager<T0, T1>(arg0));
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (v1 < 0x1::vector::length<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::Rewarder>(v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::reward_coin(0x1::vector::borrow<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::Rewarder>(v0, v1)));
            v1 = v1 + 1;
        };
        let v3 = EventPairRewardTypes{
            pair_id : 0x2::object::id<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>>(arg0),
            tokens  : v2,
        };
        0x2::event::emit<EventPairRewardTypes>(v3);
    }

    public entry fun mint_amounts<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::mint_by_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position>(v1, arg7);
    }

    public entry fun mint_by_strategy<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 || arg5 > 0, 9223372470646472703);
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::active_index(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0));
        if (arg9 > 0) {
            assert!(v0 >= arg9, 1);
        };
        if (arg10 > 0) {
            assert!(v0 <= arg10, 1);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0);
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::borrow_bin<T0, T1>(arg0, v0);
        let v3 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v2);
        let v4 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v2);
        let (v5, v6) = get_distribution_by_strategy(arg6, arg7, arg8, v0);
        let v7 = v5;
        let (v8, v9) = if (arg4 > 0 && arg5 > 0) {
            if (v0 < arg7 || v0 > arg8) {
                abort 3
            };
            0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_amount_both_side(v0, v1, arg4, arg5, v3, v4, v7, v6)
        } else if (arg4 > 0 && arg5 == 0) {
            if (v0 < arg7) {
                abort 3
            };
            if (v0 > arg8) {
                let v10 = 0x1::vector::empty<u64>();
                let v11 = 0;
                while (v11 < 0x1::vector::length<u32>(&v7)) {
                    0x1::vector::push_back<u64>(&mut v10, 0);
                    v11 = v11 + 1;
                };
                (0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_amount_ask_side(v0, v1, arg4, v7, v6), v10)
            } else {
                let v12 = 0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::auto_fill_y_by_strategy(v0, v1, arg4, v3, v4, arg7, arg8, arg6);
                assert!(v12 >= arg11 && v12 <= arg12, 2);
                0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_amount_both_side(v0, v1, arg4, v12, v3, v4, v7, v6)
            }
        } else if (v0 < arg7) {
            let v13 = 0x1::vector::empty<u64>();
            let v14 = 0;
            while (v14 < 0x1::vector::length<u32>(&v7)) {
                0x1::vector::push_back<u64>(&mut v13, 0);
                v14 = v14 + 1;
            };
            (v13, 0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v7, v6))
        } else {
            if (v0 > arg8) {
                abort 3
            };
            let v15 = 0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::auto_fill_x_by_strategy(v0, v1, arg5, v3, v4, arg7, arg8, arg6);
            assert!(v15 >= arg11 && v15 <= arg12, 2);
            0x89262527361173a459ba742359139541688cae1b2c1aa939daaa0e96d6a7c121::dlmm_pair_utils::to_amount_both_side(v0, v1, v15, arg5, v3, v4, v7, v6)
        };
        let v16 = 0x2::tx_context::sender(arg14);
        mint_amounts<T0, T1>(arg0, arg1, arg2, arg3, v7, v8, v9, v16, arg13, arg14);
    }

    public entry fun mint_percent<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u64>, arg8: vector<u64>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position>(v1, arg9);
    }

    public entry fun pair_liquidity<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::fetch_bins<T0, T1>(arg0, 0, 9223372036854775808);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u32>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::Bin>(&v0)) {
            let v8 = 0x1::vector::borrow<0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::Bin>(&v0, v7);
            0x1::vector::push_back<u32>(&mut v3, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::storage_id(v8));
            v1 = v1 + 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v8);
            v2 = v2 + 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v8);
            0x1::vector::push_back<u64>(&mut v4, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v8));
            0x1::vector::push_back<u64>(&mut v5, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v8));
            v6 = v6 + 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::bin_total_supply<T0, T1>(arg0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::storage_id(v8));
            v7 = v7 + 1;
        };
        let v9 = EventPairLiquidity{
            shares    : v6,
            liquidity : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::liquidity<T0, T1>(arg0),
            x         : v1,
            y         : v2,
            bin_ids   : v3,
            bin_x     : v4,
            bin_y     : v5,
        };
        0x2::event::emit<EventPairLiquidity>(v9);
    }

    public entry fun position_liquidity<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = *0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::bin_ids(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::position_info(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::position_manager<T0, T1>(arg0), arg1));
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&v0)) {
            let v8 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::borrow_bin<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7));
            let v9 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v8);
            let v10 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::bin_share(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::position_info(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7));
            let (v11, v12) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::get_amount_out_of_bin(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v8), v9, v10, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::bin_total_supply<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7)));
            0x1::vector::push_back<u64>(&mut v4, v11);
            0x1::vector::push_back<u64>(&mut v5, v12);
            v1 = v1 + v11;
            v2 = v2 + v12;
            v3 = v3 + v10;
            0x1::vector::push_back<u256>(&mut v6, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::bin_liquidity(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::position_info(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7)));
            v7 = v7 + 1;
        };
        let v13 = EventPositionLiquidity{
            shares        : v3,
            liquidity     : 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::liquidity(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position_info::position_info(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::position_manager<T0, T1>(arg0), arg1)),
            x_equivalent  : v1,
            y_equivalent  : v2,
            bin_ids       : v0,
            bin_x_eq      : v4,
            bin_y_eq      : v5,
            bin_liquidity : v6,
        };
        0x2::event::emit<EventPositionLiquidity>(v13);
    }

    public entry fun raise_position_by_amounts<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg2, arg8, arg9);
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut v5, v0);
        0x2::balance::join<T1>(&mut v4, v1);
        if (0x2::balance::value<T0>(&v5) == 0) {
            0x2::balance::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
        };
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg9), 0x2::tx_context::sender(arg9));
        };
    }

    public entry fun raise_position_by_amounts_reward1<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<T0>(&mut v6, v1);
        0x2::balance::join<T1>(&mut v5, v2);
        if (0x2::balance::value<T0>(&v6) == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T1>(&v5) == 0) {
            0x2::balance::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun raise_position_by_amounts_reward2<T0, T1, T2, T3>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v4, v5) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        0x2::balance::join<T0>(&mut v7, v2);
        0x2::balance::join<T1>(&mut v6, v3);
        if (0x2::balance::value<T0>(&v7) == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun raise_position_by_amounts_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T4>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v5, v6) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, v3);
        0x2::balance::join<T1>(&mut v7, v4);
        if (0x2::balance::value<T0>(&v8) == 0) {
            0x2::balance::destroy_zero<T0>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T1>(&v7) == 0) {
            0x2::balance::destroy_zero<T1>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun shrink_position<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223374343252213759);
        let (v0, v1) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg1, arg3, arg4);
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::shrink_position<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut v5, v0);
        0x2::balance::join<T1>(&mut v4, v1);
        if (0x2::balance::value<T0>(&v5) == 0) {
            0x2::balance::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), 0x2::tx_context::sender(arg4));
        };
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun shrink_position_reward1<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223374424856592383);
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<T0>(&mut v6, v1);
        0x2::balance::join<T1>(&mut v5, v2);
        if (0x2::balance::value<T0>(&v6) == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg5), 0x2::tx_context::sender(arg5));
        };
        if (0x2::balance::value<T1>(&v5) == 0) {
            0x2::balance::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg5), 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun shrink_position_reward2<T0, T1, T2, T3>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223374532230774783);
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v4, v5) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        0x2::balance::join<T0>(&mut v7, v2);
        0x2::balance::join<T1>(&mut v6, v3);
        if (0x2::balance::value<T0>(&v7) == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg5), 0x2::tx_context::sender(arg5));
        };
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg5), 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun shrink_position_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223374665374760959);
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v5, v6) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, v3);
        0x2::balance::join<T1>(&mut v7, v4);
        if (0x2::balance::value<T0>(&v8) == 0) {
            0x2::balance::destroy_zero<T0>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg5), 0x2::tx_context::sender(arg5));
        };
        if (0x2::balance::value<T1>(&v7) == 0) {
            0x2::balance::destroy_zero<T1>(v7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v7, arg5), 0x2::tx_context::sender(arg5));
        };
    }

    // decompiled from Move bytecode v6
}

