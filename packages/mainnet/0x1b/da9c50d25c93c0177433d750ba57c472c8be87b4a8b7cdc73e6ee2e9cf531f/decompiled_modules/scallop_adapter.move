module 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::scallop_adapter {
    public entry fun allocate_reward<T0, T1>(arg0: &0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::GlobalConfig, arg1: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::ShareSupply<T0, T1, T1>, arg2: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::Pool<T0, T1, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<u64>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::uid<T0, T1, T1>(arg2), 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::current_round<T0, T1, T1>(arg2)), 1);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::check_arrived_reward_time<T0, T1, T1>(arg2, arg8);
        let v0 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::extract_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2);
        let v1 = withdraw_from_scallop<T1>(arg3, arg4, 0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v0, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v0)), arg8, arg9);
        let v2 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::active_supply<T0, T1, T1>(arg1);
        let v3 = 0x2::balance::zero<T1>();
        let v4 = 0x2::balance::value<T1>(&v1);
        if (v2 > v4) {
            0x2::balance::join<T1>(&mut v3, 0x2::balance::split<T1>(&mut v1, v4));
        } else {
            0x2::balance::join<T1>(&mut v3, 0x2::balance::split<T1>(&mut v1, v2));
        };
        let v5 = supply_to_scallop<T0, T1>(arg3, arg4, v3, arg8, arg9);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v0, v5);
        let v6 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::borrow_mut_rewards<T0, T1, T1>(arg2);
        0x2::balance::join<T1>(v6, v1);
        let v7 = 0x2::balance::value<T1>(v6);
        let v8 = 0x2::balance::split<T1>(v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, v7 * 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::platform_ratio<T0, T1, T1>(arg2) / 10000), arg9), 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, v7 * 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::allocate_gas_payer_ratio<T0, T1, T1>(arg2) / 10000), arg9), 0x2::tx_context::sender(arg9));
        let v9 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::current_round<T0, T1, T1>(arg2);
        0x2::dynamic_field::add<u64, u64>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::uid<T0, T1, T1>(arg2), v9, 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::random_lib::verify_and_random<T0, T1, T1>(arg2, arg5, arg6, arg7, 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::total_supply<T0, T1, T1>(arg1)));
        let v10 = v9 - 1;
        let v11;
        loop {
            v11 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::extract_previous_rewards<T0, T1, T1>(arg2, v10);
            if (0x1::option::is_none<0x2::balance::Balance<T1>>(&v11)) {
                break
            };
            0x2::balance::join<T1>(&mut v8, 0x1::option::extract<0x2::balance::Balance<T1>>(&mut v11));
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v11);
            v10 = v10 - 1;
        };
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v11);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::put_current_round_reward_to_claimable<T0, T1, T1>(arg2, v8);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::reput_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2, v0);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::next_round<T0, T1, T1>(arg2);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::update_time<T0, T1, T1>(arg2, arg8);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::add_expired_data<T0, T1, T1>(arg2);
    }

    public entry fun claim_reward<T0, T1>(arg0: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::Pool<T0, T1, T1>, arg1: u64, arg2: vector<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::check_claim_expired<T0, T1, T1>(arg0, arg1, arg3);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::check_is_claimed<T0, T1, T1>(arg0, arg1);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::check_round_could_claim_reward<T0, T1, T1>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::uid<T0, T1, T1>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&arg2, v1);
            if (v0 >= 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::start_num<T0, T1, T1>(v2) && v0 <= 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::end_num<T0, T1, T1>(v2)) {
                let v3 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::extract_round_claimable_reward<T0, T1, T1>(arg0, arg1);
                0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::add_claimed_info<T0, T1, T1>(arg0, arg1, 0x2::tx_context::sender(arg4), 0x2::balance::value<T1>(&v3));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(0x1::vector::pop_back<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(arg2);
    }

    public entry fun stake<T0, T1>(arg0: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::ShareSupply<T0, T1, T1>, arg1: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::NumberPool<T0, T1, T1>, arg2: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::Pool<T0, T1, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg5);
        let v1 = supply_to_scallop<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T1>(arg5), arg6, arg7);
        if (0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::contains_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::borrow_mut_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2), v1);
        } else {
            0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::create_proof_container<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2, false, v1);
        };
        let v2 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::new_share<T0, T1, T1>(arg0, arg1, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v1), v0, arg7);
        while (!0x1::vector::is_empty<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&v2)) {
            0x2::transfer::public_transfer<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(0x1::vector::pop_back<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(&mut v2), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>>(v2);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::update_statistic_for_stake<T0, T1, T1>(arg2, 0x2::tx_context::sender(arg7), v0);
    }

    public fun supply_to_scallop<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>> {
        0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg4), arg3, arg4))
    }

    public entry fun withdraw<T0, T1>(arg0: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::ShareSupply<T0, T1, T1>, arg1: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::NumberPool<T0, T1, T1>, arg2: &mut 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::Pool<T0, T1, T1>, arg3: 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::StakedPoolShare<T0, T1, T1>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::amount<T0, T1, T1>(&arg3);
        let v1 = *0x2::dynamic_field::borrow<0x2::object::ID, u64>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::uid<T0, T1, T1>(&mut arg3), 0x2::object::uid_to_inner(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::uid<T0, T1, T1>(&mut arg3)));
        assert!(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::contains_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2), 0);
        let v2 = 0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::extract_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2);
        let v3 = 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>();
        let v4 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v2);
        if (v0 > v4) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v3, 0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v2, v4));
        } else {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v3, 0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut v2, v0));
        };
        let v5 = withdraw_from_scallop<T1>(arg4, arg5, v3, arg6, arg7);
        if (0x2::balance::value<T1>(&v5) < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, 0x2::balance::value<T1>(&v5)), arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v1), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::balance::join<T1>(0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::borrow_mut_rewards<T0, T1, T1>(arg2), v5);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::staked_share::to_number_pool<T0, T1, T1>(arg1, arg0, arg3);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::update_statistic_for_withdraw<T0, T1, T1>(arg2, 0x2::tx_context::sender(arg7), v1);
        0x1bda9c50d25c93c0177433d750ba57c472c8be87b4a8b7cdc73e6ee2e9cf531f::pool::reput_proof<T0, T1, T1, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>>(arg2, v2);
    }

    public fun withdraw_from_scallop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg4), arg3, arg4))
    }

    // decompiled from Move bytecode v6
}

