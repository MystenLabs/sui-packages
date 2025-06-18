module 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_script {
    struct EventFetchBins has copy, drop, store {
        bins: vector<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::Bin>,
    }

    struct EventPairParams has copy, drop, store {
        params: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPairParameter,
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
        position_id: 0x2::object::ID,
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

    public entry fun swap<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
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

    fun amounts_sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun burn_position<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, &arg1, arg2, arg3);
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::burn_position<T0, T1>(arg0, arg1, arg2, arg3);
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

    public entry fun burn_position_reward1<T0, T1, T2>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
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

    public entry fun burn_position_reward2<T0, T1, T2, T3>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v4, v5) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
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

    public entry fun burn_position_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T4>(arg0, arg1, &arg2, arg3, arg4);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, &arg2, arg3, arg4);
        let (v5, v6) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::burn_position<T0, T1>(arg0, arg2, arg3, arg4);
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

    public entry fun collect_fees<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg1, arg2, arg3);
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

    public entry fun collect_reward<T0, T1, T2>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    public entry fun collect_reward2<T0, T1, T2, T3>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
    }

    public entry fun collect_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg3, arg4);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
    }

    public entry fun create_pair<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>>(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::create_pair_by_preset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public entry fun create_pair_add_liquidity<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg1: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg2: u64, arg3: u16, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: vector<u32>, arg8: vector<u64>, arg9: vector<u64>, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::create_pair_by_preset<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg12);
        let (_, v2) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::mint_by_amounts<T0, T1>(&mut v0, arg0, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position>(v2, arg10);
        0x2::transfer::public_share_object<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>>(v0);
    }

    public entry fun deposit_reward<T0>(arg0: &0x771249e154f5d1c8dc70738df3ce452afc979046bc89bd8d7d32c54254d1940c::config::GlobalConfig, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: 0x2::coin::Coin<T0>) {
        0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun earned_fees<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_fees<T0, T1>(arg0, arg1);
        let v2 = EventEarnedFees{
            position_id : arg1,
            x           : 0x1::type_name::get<T0>(),
            y           : 0x1::type_name::get<T1>(),
            fee_x       : v0,
            fee_y       : v1,
        };
        0x2::event::emit<EventEarnedFees>(v2);
    }

    public entry fun earned_reward3<T0, T1, T2, T3, T4>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards3{
            position_id : arg1,
            reward1     : 0x1::type_name::get<T2>(),
            reward2     : 0x1::type_name::get<T3>(),
            reward3     : 0x1::type_name::get<T4>(),
            amount1     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
            amount2     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T3>(arg0, arg1, arg2),
            amount3     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T4>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards3>(v0);
    }

    public entry fun earned_rewards<T0, T1, T2>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards{
            position_id : arg1,
            reward      : 0x1::type_name::get<T2>(),
            amount      : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards>(v0);
    }

    public entry fun earned_rewards2<T0, T1, T2, T3>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = EventEarnedRewards2{
            position_id : arg1,
            reward1     : 0x1::type_name::get<T2>(),
            reward2     : 0x1::type_name::get<T3>(),
            amount1     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T2>(arg0, arg1, arg2),
            amount2     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::earned_reward<T0, T1, T3>(arg0, arg1, arg2),
        };
        0x2::event::emit<EventEarnedRewards2>(v0);
    }

    fun extra_amount_x(arg0: u64, arg1: u8, arg2: u32, arg3: u32, arg4: u32, arg5: u16, arg6: &vector<u32>, arg7: &vector<u64>) : vector<u64> {
        let (v0, v1) = get_distribution_by_strategy(arg1, arg3, arg4, arg2);
        let v2 = v0;
        let (v3, _) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(arg2, arg5, arg0, 0, 0, 0, v2, v1);
        let v5 = v3;
        let v6 = 0;
        let v7 = 0x1::vector::empty<u64>();
        while (v6 < 0x1::vector::length<u32>(arg6)) {
            if (*0x1::vector::borrow<u32>(arg6, v6) < arg2) {
                0x1::vector::push_back<u64>(&mut v7, *0x1::vector::borrow<u64>(arg7, v6));
            } else {
                0x1::vector::push_back<u64>(&mut v7, *0x1::vector::borrow<u64>(arg7, v6) + *0x1::vector::borrow<u64>(&v5, v6 - 0x1::vector::length<u32>(arg6) - 0x1::vector::length<u32>(&v2)));
            };
            v6 = v6 + 1;
        };
        v7
    }

    fun extra_amount_y(arg0: u64, arg1: u8, arg2: u32, arg3: u32, arg4: u32, arg5: u16, arg6: &vector<u32>, arg7: &vector<u64>) : vector<u64> {
        let (v0, v1) = get_distribution_by_strategy(arg1, arg3, arg4, arg2);
        let (_, v3) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(arg2, arg5, 0, arg0, 0, 0, v0, v1);
        let v4 = v3;
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        while (v5 < 0x1::vector::length<u32>(arg6)) {
            if (*0x1::vector::borrow<u32>(arg6, v5) > arg2) {
                0x1::vector::push_back<u64>(&mut v6, *0x1::vector::borrow<u64>(arg7, v5));
            } else {
                0x1::vector::push_back<u64>(&mut v6, *0x1::vector::borrow<u64>(arg7, v5) + *0x1::vector::borrow<u64>(&v4, v5));
            };
            v5 = v5 + 1;
        };
        v6
    }

    public entry fun fetch_bins<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = EventFetchBins{bins: 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::fetch_bins<T0, T1>(arg0, arg1, arg2)};
        0x2::event::emit<EventFetchBins>(v0);
    }

    public entry fun fetch_pair_params<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>) {
        let v0 = EventPairParams{params: *0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::params<T0, T1>(arg0)};
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
            0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(arg1, arg2)
        } else if (*v0 == 2) {
            if (arg3 > arg2) {
                0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg1, arg2)
            } else if (arg3 < arg1) {
                0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg1, arg2)
            } else {
                0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_curve(arg1, arg2, arg3)
            }
        } else {
            assert!(*v0 == 3, 4);
            let (v3, v4) = if (arg3 > arg2) {
                let (v5, v6) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg1, arg2);
                (v6, v5)
            } else {
                let (v7, v8) = if (arg3 < arg1) {
                    0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg1, arg2)
                } else {
                    0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_bid_ask(arg1, arg2, arg3)
                };
                (v8, v7)
            };
            (v4, v3)
        }
    }

    public entry fun get_pair_rewarders<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::borrow_rewarders(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::rewarder_manager<T0, T1>(arg0));
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (v1 < 0x1::vector::length<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::Rewarder>(v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v2, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::reward_coin(0x1::vector::borrow<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::Rewarder>(v0, v1)));
            v1 = v1 + 1;
        };
        let v3 = EventPairRewardTypes{
            pair_id : 0x2::object::id<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>>(arg0),
            tokens  : v2,
        };
        0x2::event::emit<EventPairRewardTypes>(v3);
    }

    public entry fun mint_amounts<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::mint_by_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position>(v1, arg7);
    }

    public entry fun mint_by_strategy<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: u8, arg9: u32, arg10: u32, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 || arg7 > 0, 13906835853675593727);
        assert!(arg4 || arg6, 13906835857970561023);
        if (arg4 && arg6) {
            assert!(arg13 == 0 && arg14 == 0, 5);
        };
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::active_index(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::params<T0, T1>(arg0));
        if (arg11 > 0) {
            assert!(v0 >= arg11, 1);
        };
        if (arg12 > 0) {
            assert!(v0 <= arg12, 1);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0);
        let (v2, v3) = if (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::has_bin<T0, T1>(arg0, v0)) {
            let v4 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::borrow_bin<T0, T1>(arg0, v0);
            (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v4), 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v4))
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
            let (v11, v12) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, v1, arg5, arg7, v2, v3, v7, v6);
            let v13 = v12;
            let v14 = v11;
            let v15 = amounts_sum(&v14);
            let v16 = amounts_sum(&v13);
            if (v15 < arg5) {
                let v17 = &v14;
                v14 = extra_amount_x(arg5 - v15, arg8, v0, arg9, arg10, v1, &v7, v17);
            };
            if (v16 < arg7) {
                let v18 = &v13;
                v13 = extra_amount_y(arg7 - v16, arg8, v0, arg9, arg10, v1, &v7, v18);
            };
            (v14, v13)
        } else if (arg4) {
            if (v0 < arg9) {
                let v19 = vector[];
                let v20 = 0;
                while (v20 < 0x1::vector::length<u32>(&v7)) {
                    0x1::vector::push_back<u64>(&mut v19, 0);
                    v20 = v20 + 1;
                };
                (0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, v1, arg5, v7, v6), v19)
            } else {
                assert!(v0 >= arg9 && v0 <= arg10, 3);
                let v21 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::auto_fill_y_by_weight(v0, v1, arg5, v2, v3, v7, v6);
                assert!(v21 >= arg13 && v21 <= arg14, 2);
                0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, v1, arg5, v21, v2, v3, v7, v6)
            }
        } else if (v0 > arg10) {
            let v22 = vector[];
            let v23 = 0;
            while (v23 < 0x1::vector::length<u32>(&v7)) {
                0x1::vector::push_back<u64>(&mut v22, 0);
                v23 = v23 + 1;
            };
            (v22, 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg7, v7, v6))
        } else {
            assert!(v0 >= arg9 && v0 <= arg10, 3);
            let v24 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::auto_fill_x_by_weight(v0, v1, arg7, v2, v3, v7, v6);
            assert!(v24 >= arg13 && v24 <= arg14, 2);
            0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, v1, v24, arg7, v2, v3, v7, v6)
        };
        let (v25, v26, v27) = filter_empty_bins(v7, v8, v9);
        let v28 = 0x2::tx_context::sender(arg16);
        mint_amounts<T0, T1>(arg0, arg1, arg2, arg3, v25, v26, v27, v28, arg15, arg16);
    }

    public entry fun mint_by_strategy_single<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u8, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 || arg5 > 0, 13906834672559587327);
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::active_index(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::params<T0, T1>(arg0));
        if (arg9 > 0) {
            assert!(v0 >= arg9, 1);
        };
        if (arg10 > 0) {
            assert!(v0 <= arg10, 1);
        };
        let (v1, v2) = if (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::has_bin<T0, T1>(arg0, v0)) {
            let v3 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::borrow_bin<T0, T1>(arg0, v0);
            (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v3), 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v3))
        } else {
            (0, 0)
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u32>();
        let v7 = &arg6;
        if (*v7 == 1) {
            if (v0 < arg7 || v0 > arg8) {
                let (v8, v9) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(arg7, arg8);
                let (v10, v11) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v8, v9);
                v6 = v8;
                v4 = v10;
                v5 = v11;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v12, v13) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(arg7, v0);
                    let v14 = v12;
                    let v15 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v14, v13);
                    let v16 = 0;
                    while (v16 < 0x1::vector::length<u32>(&v14)) {
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v15, v16));
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v14, v16));
                        v16 = v16 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v17, v18) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(v0 + 1, arg8);
                    let v19 = v17;
                    let v20 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v19, v18);
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
                    let (v22, v23) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(arg7, v0 - 1);
                    let v24 = v22;
                    let v25 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v24, v23);
                    let v26 = 0;
                    while (v26 < 0x1::vector::length<u32>(&v24)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v24, v26));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v25, v26));
                        v26 = v26 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v27, v28) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_spot_balanced(v0, arg8);
                    let v29 = v27;
                    let v30 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v29, v28);
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
                let (v32, v33) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg7, arg8);
                let (v34, v35) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v32, v33);
                v6 = v32;
                v4 = v34;
                v5 = v35;
            } else if (v0 > arg8) {
                let (v36, v37) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg7, arg8);
                let (v38, v39) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v36, v37);
                v6 = v36;
                v4 = v38;
                v5 = v39;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v40, v41) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg7, v0);
                    let v42 = v40;
                    let v43 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v42, v41);
                    let v44 = 0;
                    while (v44 < 0x1::vector::length<u32>(&v42)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v42, v44));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v43, v44));
                        v44 = v44 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v45, v46) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(v0 + 1, arg8);
                    let v47 = v45;
                    let v48 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v47, v46);
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
                    let (v50, v51) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg7, v0 - 1);
                    let v52 = v50;
                    let v53 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v52, v51);
                    let v54 = 0;
                    while (v54 < 0x1::vector::length<u32>(&v52)) {
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v53, v54));
                        v54 = v54 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v55, v56) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(v0, arg8);
                    let v57 = v55;
                    let v58 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v57, v56);
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
                let (v60, v61) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(arg7, arg8);
                let (v62, v63) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v60, v61);
                v6 = v60;
                v4 = v62;
                v5 = v63;
            } else if (v0 > arg8) {
                let (v64, v65) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg7, arg8);
                let (v66, v67) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, arg5, v1, v2, v64, v65);
                v6 = v64;
                v4 = v66;
                v5 = v67;
            } else if (!(arg5 == 0)) {
                if (arg7 <= v0) {
                    let (v68, v69) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg7, v0);
                    let v70 = v68;
                    let v71 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v70, v69);
                    let v72 = 0;
                    while (v72 < 0x1::vector::length<u32>(&v70)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v70, v72));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v71, v72));
                        v72 = v72 + 1;
                    };
                };
                if (v0 < arg8) {
                    let (v73, v74) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(v0 + 1, arg8);
                    let v75 = v73;
                    let v76 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v75, v74);
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
                    let (v78, v79) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_descending_order(arg7, v0 - 1);
                    let v80 = v78;
                    let v81 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v0, arg5, v80, v79);
                    let v82 = 0;
                    while (v82 < 0x1::vector::length<u32>(&v80)) {
                        0x1::vector::push_back<u32>(&mut v6, *0x1::vector::borrow<u32>(&v80, v82));
                        0x1::vector::push_back<u64>(&mut v4, 0);
                        0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v81, v82));
                        v82 = v82 + 1;
                    };
                };
                if (v0 <= arg8) {
                    let (v83, v84) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_weight_ascending_order(v0, arg8);
                    let v85 = v83;
                    let v86 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0), arg4, v85, v84);
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

    public entry fun mint_percent<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: vector<u32>, arg7: vector<u64>, arg8: vector<u64>, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position>(v1, arg9);
    }

    public entry fun pair_liquidity<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::fetch_bins<T0, T1>(arg0, 0, 9223372036854775808);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u32>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::Bin>(&v0)) {
            let v8 = 0x1::vector::borrow<0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::Bin>(&v0, v7);
            0x1::vector::push_back<u32>(&mut v3, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::storage_id(v8));
            v1 = v1 + 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v8);
            v2 = v2 + 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v8);
            0x1::vector::push_back<u64>(&mut v4, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v8));
            0x1::vector::push_back<u64>(&mut v5, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v8));
            v6 = v6 + 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::bin_total_supply<T0, T1>(arg0, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::storage_id(v8));
            v7 = v7 + 1;
        };
        let v9 = EventPairLiquidity{
            shares    : v6,
            liquidity : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::liquidity<T0, T1>(arg0),
            x         : v1,
            y         : v2,
            bin_ids   : v3,
            bin_x     : v4,
            bin_y     : v5,
        };
        0x2::event::emit<EventPairLiquidity>(v9);
    }

    public entry fun position_liquidity<T0, T1>(arg0: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: 0x2::object::ID) {
        let v0 = *0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::bin_ids(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::position_info(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::position_manager<T0, T1>(arg0), arg1));
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&v0)) {
            let v8 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::borrow_bin<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7));
            let v9 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v8);
            let v10 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::bin_share(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::position_info(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7));
            let (v11, v12) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::get_amount_out_of_bin(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v8), v9, v10, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::bin_total_supply<T0, T1>(arg0, *0x1::vector::borrow<u32>(&v0, v7)));
            0x1::vector::push_back<u64>(&mut v4, v11);
            0x1::vector::push_back<u64>(&mut v5, v12);
            v1 = v1 + v11;
            v2 = v2 + v12;
            v3 = v3 + v10;
            0x1::vector::push_back<u256>(&mut v6, 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::bin_liquidity(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::position_info(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::position_manager<T0, T1>(arg0), arg1), *0x1::vector::borrow<u32>(&v0, v7)));
            v7 = v7 + 1;
        };
        let v13 = EventPositionLiquidity{
            position_id   : arg1,
            shares        : v3,
            liquidity     : 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::liquidity(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position_info::position_info(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::position_manager<T0, T1>(arg0), arg1)),
            x_equivalent  : v1,
            y_equivalent  : v2,
            bin_ids       : v0,
            bin_x_eq      : v4,
            bin_y_eq      : v5,
            bin_liquidity : v6,
        };
        0x2::event::emit<EventPositionLiquidity>(v13);
    }

    public entry fun raise_by_strategy<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: u8, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::vector::borrow<u32>(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::ids(arg2), 0);
        let v1 = *0x1::vector::borrow<u32>(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::ids(arg2), 0x1::vector::length<u32>(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::ids(arg2)) - 1);
        assert!(arg6 > 0 || arg8 > 0, 13906837563072577535);
        assert!(arg5 || arg7, 13906837567367544831);
        if (arg5 && arg7) {
            assert!(arg12 == 0 && arg13 == 0, 5);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::active_index(0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::params<T0, T1>(arg0));
        if (arg10 > 0) {
            assert!(v2 >= arg10, 1);
        };
        if (arg11 > 0) {
            assert!(v2 <= arg11, 1);
        };
        let v3 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::get_bin_step<T0, T1>(arg0);
        let (v4, v5) = if (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::has_bin<T0, T1>(arg0, v2)) {
            let v6 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::borrow_bin<T0, T1>(arg0, v2);
            (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_x(v6), 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_bin::reserve_y(v6))
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
            let (v13, v14) = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v2, v3, arg6, arg8, v4, v5, v9, v8);
            let v15 = v14;
            let v16 = v13;
            let v17 = amounts_sum(&v16);
            let v18 = amounts_sum(&v15);
            if (v17 < arg6) {
                let v19 = &v16;
                v16 = extra_amount_x(arg6 - v17, arg9, v2, v0, v1, v3, &v9, v19);
            };
            if (v18 < arg8) {
                let v20 = &v15;
                v15 = extra_amount_y(arg8 - v18, arg9, v2, v0, v1, v3, &v9, v20);
            };
            (v16, v15)
        } else if (arg5) {
            if (v2 < v0) {
                let v21 = vector[];
                let v22 = 0;
                while (v22 < 0x1::vector::length<u32>(&v9)) {
                    0x1::vector::push_back<u64>(&mut v21, 0);
                    v22 = v22 + 1;
                };
                (0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_ask_side(v2, v3, arg6, v9, v8), v21)
            } else {
                assert!(v2 >= v0 && v2 <= v1, 3);
                let v23 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::auto_fill_y_by_weight(v2, v3, arg6, v4, v5, v9, v8);
                assert!(v23 >= arg12 && v23 <= arg13, 2);
                0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v2, v3, arg6, v23, v4, v5, v9, v8)
            }
        } else if (v2 > v1) {
            let v24 = vector[];
            let v25 = 0;
            while (v25 < 0x1::vector::length<u32>(&v9)) {
                0x1::vector::push_back<u64>(&mut v24, 0);
                v25 = v25 + 1;
            };
            (v24, 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_bid_side(v2, arg8, v9, v8))
        } else {
            assert!(v2 >= v0 && v2 <= v1, 3);
            let v26 = 0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::auto_fill_x_by_weight(v2, v3, arg8, v4, v5, v9, v8);
            assert!(v26 >= arg12 && v26 <= arg13, 2);
            0x20ceae4f967df1322d736b061ea2170f897f0e2cce8ec7b9b813912877356430::almm_pair_utils::to_amount_both_side(v2, v3, v26, arg8, v4, v5, v9, v8)
        };
        let (v27, _, _) = filter_empty_bins(v9, v10, v11);
        let v30 = v27;
        if (0x1::vector::length<u32>(&v9) != 0x1::vector::length<u32>(&v30)) {
            abort 6
        };
        let v31 = 0x2::tx_context::sender(arg15);
        raise_position_by_amounts<T0, T1>(arg0, arg1, arg2, arg3, arg4, v10, v11, v31, arg14, arg15);
    }

    public entry fun raise_by_strategy_1<T0, T1, T2>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
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

    public entry fun raise_by_strategy_2<T0, T1, T2, T3>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
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

    public entry fun raise_by_strategy_3<T0, T1, T2, T3, T4>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T4>(arg0, arg2, arg3, arg15, arg16);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg15, arg16);
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

    public entry fun raise_position_by_amounts<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg2, arg8, arg9);
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7, arg8, arg9);
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

    public entry fun raise_position_by_amounts_reward1<T0, T1, T2>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
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

    public entry fun raise_position_by_amounts_reward2<T0, T1, T2, T3>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v4, v5) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
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

    public entry fun raise_position_by_amounts_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_factory::Factory, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg3: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: vector<u64>, arg7: vector<u64>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T4>(arg0, arg2, arg3, arg9, arg10);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg3, arg9, arg10);
        let (v5, v6) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::raise_position_by_amounts<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9, arg10);
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

    public entry fun shrink_position<T0, T1>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::basis_point_max() as u64), 13906838817203027967);
        let (v0, v1) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg1, arg3, arg4);
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::shrink_position<T0, T1>(arg0, arg1, arg2, arg3, arg4);
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

    public entry fun shrink_position_reward1<T0, T1, T2>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::basis_point_max() as u64), 13906838898807406591);
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let (v1, v2) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
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

    public entry fun shrink_position_reward2<T0, T1, T2, T3>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::basis_point_max() as u64), 13906839006181588991);
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let (v2, v3) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v4, v5) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
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

    public entry fun shrink_position_reward3<T0, T1, T2, T3, T4>(arg0: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::AlmmPair<T0, T1>, arg1: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_rewarder::RewarderGlobalVault, arg2: &mut 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_position::Position, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < (0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_constants::basis_point_max() as u64), 13906839139325575167);
        let v0 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
        let v1 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T3>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T3>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T3>(v1);
        };
        let v2 = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg4, arg5);
        if (0x2::balance::value<T4>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v2, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T4>(v2);
        };
        let (v3, v4) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::collect_fees<T0, T1>(arg0, arg2, arg4, arg5);
        let (v5, v6) = 0x5c4774a8a1e31068e6bc74ac726a1fa6a6231a51e8c1c442f8b87e636b2e2b5a::almm_pair::shrink_position<T0, T1>(arg0, arg2, arg3, arg4, arg5);
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

