module 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::scallop_adapter {
    public entry fun allocate_reward<T0>(arg0: &0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::GlobalConfig, arg1: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::ShareSupply<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg2: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::Pool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<u64>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::uid<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2), 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::current_round<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2)), 1);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::check_arrived_reward_time<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, arg8);
        let v0 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::extract_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2);
        let v1 = withdraw_from_scallop<T0>(arg3, arg4, 0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut v0, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0)), arg8, arg9);
        let v2 = supply_to_scallop<T0>(arg3, arg4, 0x2::balance::split<T0>(&mut v1, 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::active_supply<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg1)), arg8, arg9);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut v0, v2);
        let v3 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::borrow_mut_rewards<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2);
        0x2::balance::join<T0>(v3, v1);
        let v4 = 0x2::balance::value<T0>(v3);
        let v5 = 0x2::balance::split<T0>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v4 * 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::platform_ratio<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2) / 10000), arg9), 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v4 * 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::allocate_gas_payer_ratio<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2) / 10000), arg9), 0x2::tx_context::sender(arg9));
        let v6 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::current_round<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2);
        0x2::dynamic_field::add<u64, u64>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::uid<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2), v6, 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::random_lib::verify_and_random<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, arg5, arg6, arg7, 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::total_supply<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg1)));
        let v7 = v6 - 1;
        let v8;
        loop {
            v8 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::extract_previous_rewards<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, v7);
            if (0x1::option::is_none<0x2::balance::Balance<T0>>(&v8)) {
                break
            };
            0x2::balance::join<T0>(&mut v5, 0x1::option::extract<0x2::balance::Balance<T0>>(&mut v8));
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v8);
            v7 = v7 - 1;
        };
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v8);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::put_current_round_reward_to_claimable<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, v5);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::reput_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2, v0);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::next_round<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::update_time<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, arg8);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::add_expired_data<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2);
    }

    public entry fun claim_reward<T0>(arg0: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::Pool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg1: u64, arg2: vector<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::check_claim_expired<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0, arg1, arg3);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::check_is_claimed<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0, arg1);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::check_round_could_claim_reward<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::uid<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&arg2, v1);
            if (v0 >= 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::start_num<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(v2) && v0 <= 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::end_num<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::extract_round_claimable_reward<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0, arg1), arg4), 0x2::tx_context::sender(arg4));
                0x2::table::add<u64, address>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::borrow_mut_claimed<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0), arg1, 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(0x1::vector::pop_back<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(arg2);
    }

    public entry fun stake<T0>(arg0: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::ShareSupply<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg1: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::NumberPool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg2: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::Pool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = supply_to_scallop<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7);
        if (0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::contains_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::borrow_mut_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2), v1);
        } else {
            0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::create_proof_container<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2, false, v1);
        };
        let v2 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::new_share<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg0, arg1, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1), v0, arg7);
        while (!0x1::vector::is_empty<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&v2)) {
            0x2::transfer::public_transfer<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(0x1::vector::pop_back<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(&mut v2), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>>(v2);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::update_statistic_for_stake<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, 0x2::tx_context::sender(arg7), v0);
    }

    public fun supply_to_scallop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg4), arg3, arg4))
    }

    public entry fun withdraw<T0>(arg0: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::ShareSupply<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg1: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::NumberPool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg2: &mut 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::Pool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg3: 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::StakedPoolShare<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::dynamic_field::borrow<0x2::object::ID, u64>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::uid<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(&mut arg3), 0x2::object::uid_to_inner(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::uid<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(&mut arg3)));
        assert!(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::contains_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2), 0);
        let v1 = 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::extract_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2);
        let v2 = withdraw_from_scallop<T0>(arg4, arg5, 0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut v1, 0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::amount<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(&arg3)), arg6, arg7);
        if (0x2::balance::value<T0>(&v2) < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, 0x2::balance::value<T0>(&v2)), arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::balance::join<T0>(0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::borrow_mut_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<T0>>(arg2), v2);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::staked_share::to_number_pool<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg1, arg0, arg3);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::update_statistic_for_withdraw<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0>(arg2, 0x2::tx_context::sender(arg7), v0);
        0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::reput_proof<0xc4736d3dc72dad5045e48ee34d2a84b94c5f409bd183281144fe8cdfba248f05::pool::SCALLOP_PROTOCOL, T0, T0, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg2, v1);
    }

    public fun withdraw_from_scallop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg2, arg4), arg3, arg4))
    }

    // decompiled from Move bytecode v6
}

