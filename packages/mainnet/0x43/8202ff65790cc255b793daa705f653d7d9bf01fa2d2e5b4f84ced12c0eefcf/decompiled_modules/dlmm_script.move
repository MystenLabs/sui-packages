module 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_script {
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

    public entry fun fetch_bins<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = EventFetchBins{bins: 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::fetch_bins<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<EventFetchBins>(v0);
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

    public entry fun shrink_position<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223376404836515839);
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

    public entry fun fetch_pair_params<T0, T1>(arg0: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>) {
        let v0 = EventPairParams{params: *0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0)};
        0x2::event::emit<EventPairParams>(v0);
    }

    fun filter_empty_bins(arg0: vector<u32>, arg1: vector<u64>, arg2: vector<u64>) : (vector<u32>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u32>(&arg0)) {
            if (*0x1::vector::borrow<u64>(&arg1, v3) != 0 || *0x1::vector::borrow<u64>(&arg2, v3) != 0) {
                0x1::vector::push_back<u32>(&mut v0, *0x1::vector::borrow<u32>(&arg0, v3));
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg1, v3));
                0x1::vector::push_back<u64>(&mut v2, *0x1::vector::borrow<u64>(&arg2, v3));
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun get_distribution_by_strategy(arg0: u8, arg1: u32, arg2: u32, arg3: u32) : (vector<u32>, vector<u256>) {
        let v0 = &arg0;
        if (*v0 == 1) {
            0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(arg1, arg2)
        } else if (*v0 == 2) {
            if (arg3 > arg2) {
                0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg1, arg2)
            } else if (arg3 < arg1) {
                0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg1, arg2)
            } else {
                0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_curve(arg1, arg2, arg3)
            }
        } else {
            assert!(*v0 == 3, 4);
            let (v3, v4) = if (arg3 > arg2) {
                let (v5, v6) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg1, arg2);
                (v6, v5)
            } else {
                let (v7, v8) = if (arg3 < arg1) {
                    0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg1, arg2)
                } else {
                    0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_bid_ask(arg1, arg2, arg3)
                };
                (v8, v7)
            };
            (v4, v3)
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

    public entry fun mint_by_strategy<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: u8, arg9: u32, arg10: u32, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 || arg7 > 0, 9223373522913460223);
        assert!(arg4 || arg6, 9223373527208427519);
        if (arg4 && arg6) {
            assert!(arg13 == 0 && arg14 == 0, 5);
        };
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::active_index(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0));
        if (arg11 > 0) {
            assert!(v0 >= arg11, 1);
        };
        if (arg12 > 0) {
            assert!(v0 <= arg12, 1);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0);
        let (v2, v3) = if (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::has_bin<T0, T1>(arg0, v0)) {
            let v4 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::borrow_bin<T0, T1>(arg0, v0);
            (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v4), 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v4))
        } else {
            (0, 0)
        };
        let (v5, v6) = get_distribution_by_strategy(arg8, arg9, arg10, v0);
        let v7 = v5;
        let (v8, v9) = if (arg4 && arg6) {
            let v10 = if (arg5 > 0) {
                if (arg7 > 0) {
                    v0 < arg9 || v0 > arg10
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                abort 3
            };
            0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, v1, arg5, arg7, v2, v3, v7, v6)
        } else if (arg4) {
            if (v0 < arg9) {
                let v11 = vector[];
                let v12 = 0;
                while (v12 < 0x1::vector::length<u32>(&v7)) {
                    0x1::vector::push_back<u64>(&mut v11, 0);
                    v12 = v12 + 1;
                };
                (0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, v1, arg5, v7, v6), v11)
            } else {
                assert!(v0 >= arg9 && v0 <= arg10, 3);
                let v13 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::auto_fill_y_by_weight(v0, v1, arg5, v2, v3, v7, v6);
                assert!(v13 >= arg13 && v13 <= arg14, 2);
                0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, v1, arg5, v13, v2, v3, v7, v6)
            }
        } else if (v0 > arg10) {
            let v14 = vector[];
            let v15 = 0;
            while (v15 < 0x1::vector::length<u32>(&v7)) {
                0x1::vector::push_back<u64>(&mut v14, 0);
                v15 = v15 + 1;
            };
            (v14, 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg7, v7, v6))
        } else {
            assert!(v0 >= arg9 && v0 <= arg10, 3);
            let v16 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::auto_fill_x_by_weight(v0, v1, arg7, v2, v3, v7, v6);
            assert!(v16 >= arg13 && v16 <= arg14, 2);
            0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, v1, v16, arg7, v2, v3, v7, v6)
        };
        let (v17, v18, v19) = filter_empty_bins(v7, v8, v9);
        let v20 = 0x2::tx_context::sender(arg16);
        mint_amounts<T0, T1>(arg0, arg1, arg2, arg3, v17, v18, v19, v20, arg15, arg16);
    }

    public entry fun mint_by_strategy_single<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 || arg5 > 0, 9223372535070982143);
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::active_index(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0));
        if (arg9 > 0) {
            assert!(v0 >= arg9, 1);
        };
        if (arg10 > 0) {
            assert!(v0 <= arg10, 1);
        };
        let (v1, v2) = if (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::has_bin<T0, T1>(arg0, v0)) {
            let v3 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::borrow_bin<T0, T1>(arg0, v0);
            (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v3), 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v3))
        } else {
            (0, 0)
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u32>();
        let v7 = &arg6;
        if (*v7 == 1) {
            if (v0 < arg7 || v0 > arg8) {
                let (v8, v9) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(arg7, arg8);
                let (v10, v11) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v8, v9);
                v6 = v8;
                v4 = v10;
                v5 = v11;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v12, v13) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(arg7, v0);
                    let v14 = v12;
                    let v15 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v14, v13);
                    let v16 = 0;
                    while (v16 < 0x1::vector::length<u32>(&v14)) {
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v15, v16));
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v14, v16));
                        v16 = v16 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v17, v18) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(v0 + 1, arg8);
                    let v19 = v17;
                    let v20 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v19, v18);
                    let v21 = 0;
                    while (v21 < 0x1::vector::length<u32>(&v19)) {
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v20, v21));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v19, v21));
                        v21 = v21 + 1;
                    };
                };
            } else {
                if (arg7 < v0) {
                    let (v22, v23) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(arg7, v0 - 1);
                    let v24 = v22;
                    let v25 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v24, v23);
                    let v26 = 0;
                    while (v26 < 0x1::vector::length<u32>(&v24)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v24, v26));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v25, v26));
                        v26 = v26 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v27, v28) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_spot_balanced(v0, arg8);
                    let v29 = v27;
                    let v30 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v29, v28);
                    let v31 = 0;
                    while (v31 < 0x1::vector::length<u32>(&v29)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v29, v31));
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v30, v31));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        v31 = v31 + 1;
                    };
                };
            };
        } else if (*v7 == 2) {
            if (v0 < arg7) {
                let (v32, v33) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg7, arg8);
                let (v34, v35) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v32, v33);
                v6 = v32;
                v4 = v34;
                v5 = v35;
            } else if (v0 > arg8) {
                let (v36, v37) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg7, arg8);
                let (v38, v39) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v36, v37);
                v6 = v36;
                v4 = v38;
                v5 = v39;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v40, v41) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg7, v0);
                    let v42 = v40;
                    let v43 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v42, v41);
                    let v44 = 0;
                    while (v44 < 0x1::vector::length<u32>(&v42)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v42, v44));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v43, v44));
                        v44 = v44 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v45, v46) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(v0 + 1, arg8);
                    let v47 = v45;
                    let v48 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v47, v46);
                    let v49 = 0;
                    while (v49 < 0x1::vector::length<u32>(&v47)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v47, v49));
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v48, v49));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        v49 = v49 + 1;
                    };
                };
            } else {
                if (arg7 < v0) {
                    let (v50, v51) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg7, v0 - 1);
                    let v52 = v50;
                    let v53 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v52, v51);
                    let v54 = 0;
                    while (v54 < 0x1::vector::length<u32>(&v52)) {
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v53, v54));
                        v54 = v54 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v55, v56) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(v0, arg8);
                    let v57 = v55;
                    let v58 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v57, v56);
                    let v59 = 0;
                    while (v59 < 0x1::vector::length<u32>(&v57)) {
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v58, v59));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        v59 = v59 + 1;
                    };
                };
            };
        } else {
            assert!(*v7 == 3, 4);
            if (v0 < arg7) {
                let (v60, v61) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(arg7, arg8);
                let (v62, v63) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v60, v61);
                v6 = v60;
                v4 = v62;
                v5 = v63;
            } else if (v0 > arg8) {
                let (v64, v65) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg7, arg8);
                let (v66, v67) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v64, v65);
                v6 = v64;
                v4 = v66;
                v5 = v67;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v68, v69) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg7, v0);
                    let v70 = v68;
                    let v71 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v70, v69);
                    let v72 = 0;
                    while (v72 < 0x1::vector::length<u32>(&v70)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v70, v72));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v71, v72));
                        v72 = v72 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v73, v74) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(v0 + 1, arg8);
                    let v75 = v73;
                    let v76 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v75, v74);
                    let v77 = 0;
                    while (v77 < 0x1::vector::length<u32>(&v75)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v75, v77));
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v76, v77));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        v77 = v77 + 1;
                    };
                };
            } else {
                if (arg7 < v0) {
                    let (v78, v79) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_descending_order(arg7, v0 - 1);
                    let v80 = v78;
                    let v81 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v0, arg5, v80, v79);
                    let v82 = 0;
                    while (v82 < 0x1::vector::length<u32>(&v80)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v80, v82));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v81, v82));
                        v82 = v82 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v83, v84) = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_weight_ascending_order(v0, arg8);
                    let v85 = v83;
                    let v86 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v0, 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0), arg4, v85, v84);
                    let v87 = 0;
                    while (v87 < 0x1::vector::length<u32>(&v85)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v85, v87));
                        0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v86, v87));
                        0x1::vector::push_back<u64>(&mut v5, 0);
                        v87 = v87 + 1;
                    };
                };
            };
        };
        let v88 = 0x2::tx_context::sender(arg14);
        mint_amounts<T0, T1>(arg0, arg1, arg2, arg3, v6, v4, v5, v88, arg13, arg14);
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

    public entry fun raise_by_strategy<T0, T1>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: u8, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::vector::borrow<u32>(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::ids(arg2), 0);
        let v1 = *0x1::vector::borrow<u32>(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::ids(arg2), 0x1::vector::length<u32>(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::ids(arg2)) - 1);
        assert!(arg6 > 0 || arg8 > 0, 9223375189360771071);
        assert!(arg5 || arg7, 9223375193655738367);
        if (arg5 && arg7) {
            assert!(arg12 == 0 && arg13 == 0, 5);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::active_index(0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::params<T0, T1>(arg0));
        if (arg10 > 0) {
            assert!(v2 >= arg10, 1);
        };
        if (arg11 > 0) {
            assert!(v2 <= arg11, 1);
        };
        let v3 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::get_bin_step<T0, T1>(arg0);
        let (v4, v5) = if (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::has_bin<T0, T1>(arg0, v2)) {
            let v6 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::borrow_bin<T0, T1>(arg0, v2);
            (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_x(v6), 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_bin::reserve_y(v6))
        } else {
            (0, 0)
        };
        let (v7, v8) = get_distribution_by_strategy(arg9, v0, v1, v2);
        let v9 = v7;
        let (v10, v11) = if (arg5 && arg7) {
            let v12 = if (arg6 > 0) {
                if (arg8 > 0) {
                    v2 < v0 || v2 > v1
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                abort 3
            };
            0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v2, v3, arg6, arg8, v4, v5, v9, v8)
        } else if (arg5) {
            if (v2 < v0) {
                let v13 = vector[];
                let v14 = 0;
                while (v14 < 0x1::vector::length<u32>(&v9)) {
                    0x1::vector::push_back<u64>(&mut v13, 0);
                    v14 = v14 + 1;
                };
                (0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_ask_side(v2, v3, arg6, v9, v8), v13)
            } else {
                assert!(v2 >= v0 && v2 <= v1, 3);
                let v15 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::auto_fill_y_by_weight(v2, v3, arg6, v4, v5, v9, v8);
                assert!(v15 >= arg12 && v15 <= arg13, 2);
                0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v2, v3, arg6, v15, v4, v5, v9, v8)
            }
        } else if (v2 > v1) {
            let v16 = vector[];
            let v17 = 0;
            while (v17 < 0x1::vector::length<u32>(&v9)) {
                0x1::vector::push_back<u64>(&mut v16, 0);
                v17 = v17 + 1;
            };
            (v16, 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_bid_side(v2, arg8, v9, v8))
        } else {
            assert!(v2 >= v0 && v2 <= v1, 3);
            let v18 = 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::auto_fill_x_by_weight(v2, v3, arg8, v4, v5, v9, v8);
            assert!(v18 >= arg12 && v18 <= arg13, 2);
            0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::dlmm_pair_utils::to_amount_both_side(v2, v3, v18, arg8, v4, v5, v9, v8)
        };
        let (v19, _, _) = filter_empty_bins(v9, v10, v11);
        let v22 = v19;
        if (0x1::vector::length<u32>(&v9) != 0x1::vector::length<u32>(&v22)) {
            abort 6
        };
        let v23 = 0x2::tx_context::sender(arg15);
        raise_position_by_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, v10, v11, v23, arg14, arg15);
    }

    public entry fun raise_by_strategy_1<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
        let v3 = v2;
        let v4 = v1;
        if (0x2::balance::value<T0>(&v4) == 0) {
            0x2::balance::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg16), 0x2::tx_context::sender(arg16));
        };
        if (0x2::balance::value<T1>(&v3) == 0) {
            0x2::balance::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg16), 0x2::tx_context::sender(arg16));
        };
        raise_by_strategy<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun raise_by_strategy_2<T0, T1, T2, T3>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T0>(&v5) == 0) {
            0x2::balance::destroy_zero<T0>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg16), 0x2::tx_context::sender(arg16));
        };
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg16), 0x2::tx_context::sender(arg16));
        };
        raise_by_strategy<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public entry fun raise_by_strategy_3<T0, T1, T2, T3, T4>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_factory::Factory, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg3: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_reward<T0, T1, T4>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
        let v5 = v4;
        let v6 = v3;
        if (0x2::balance::value<T0>(&v6) == 0) {
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg16), 0x2::tx_context::sender(arg16));
        };
        if (0x2::balance::value<T1>(&v5) == 0) {
            0x2::balance::destroy_zero<T1>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg16), 0x2::tx_context::sender(arg16));
        };
        raise_by_strategy<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
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

    public entry fun shrink_position_reward1<T0, T1, T2>(arg0: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_pair::DlmmPair<T0, T1>, arg1: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_rewarder::RewarderGlobalVault, arg2: &mut 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223376486440894463);
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
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223376593815076863);
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
        assert!(arg3 > 0 && arg3 < (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u64), 9223376726959063039);
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

