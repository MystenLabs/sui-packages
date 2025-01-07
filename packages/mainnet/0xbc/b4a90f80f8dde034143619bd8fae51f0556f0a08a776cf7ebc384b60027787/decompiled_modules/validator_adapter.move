module 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::validator_adapter {
    struct RestakeReceipt {
        dummy_field: bool,
    }

    struct StakedSuiStatus has copy, drop, store {
        available: u64,
        pending: u64,
        last_epoch: u64,
    }

    struct Status has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun allocate_reward(arg0: &0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::GlobalConfig, arg1: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::ShareSupply<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<u64>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::current_round<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3)), 1);
        let v0 = Status{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), v0);
        assert!(v1.last_epoch < 0x2::tx_context::epoch(arg9), 3);
        assert!(v1.pending == 0, 3);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::check_arrived_reward_time<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg8);
        update_available_amount_for_withdraw(arg3, v1.available);
        let (v2, v3) = withdraw_all_sui_from_validator(arg2, arg3, arg9);
        let v4 = v2;
        if (0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::contains_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3)) {
            let v5 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
            0x2::coin::join<0x2::sui::SUI>(&mut v4, 0x2::coin::split<0x2::sui::SUI>(v5, 0x2::coin::value<0x2::sui::SUI>(v5), arg9));
        };
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut v4, 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::active_supply<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1), arg9);
        update_available_amount_for_stake(arg3, 0x2::coin::value<0x2::sui::SUI>(&v6), arg9);
        let v7 = restake_all_original_sui(arg2, v6, v3, arg4, arg9);
        let v8 = vector[];
        0x1::vector::push_back<u64>(&mut v8, 0x3::staking_pool::stake_activation_epoch(&v7));
        0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v8);
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg3), 0x3::staking_pool::stake_activation_epoch(&v7), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, 0x2::coin::value<0x2::sui::SUI>(&v4) * 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::platform_ratio<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3) / 10000, arg9), 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, 0x2::coin::value<0x2::sui::SUI>(&v4) * 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::allocate_gas_payer_ratio<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3) / 10000, arg9), 0x2::tx_context::sender(arg9));
        let v9 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::current_round<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
        0x2::dynamic_field::add<u64, u64>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), v9, 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::random_lib::verify_and_random(arg5, arg6, arg7, 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::total_supply<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1)));
        let v10 = v9 - 1;
        let v11;
        loop {
            v11 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::extract_previous_rewards<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, v10);
            if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&v11)) {
                break
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v4, 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v11));
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v11);
            v10 = v10 - 1;
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v11);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::put_current_round_reward_to_claimable<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, v4);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::next_round<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::update_time<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg8);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::add_expired_data<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
    }

    public entry fun claim_reward(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: vector<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::check_claim_expired<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1, arg3);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::check_is_claimed<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::check_round_could_claim_reward<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2, v1);
            if (v0 >= 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::start_num<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(v2) && v0 <= 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::end_num<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::extract_round_claimable_reward<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1), 0x2::tx_context::sender(arg4));
                0x2::table::add<u64, address>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_claimed<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1, 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(0x1::vector::pop_back<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(arg2);
    }

    fun copy_epoch(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>) : vector<u64> {
        let v0 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), 0x1::type_name::get<0x3::staking_pool::StakedSui>());
        if (*0x1::vector::borrow<u64>(&v0, 0x1::vector::length<u64>(&v0) - 1) > *0x1::vector::borrow<u64>(&v0, 0)) {
            0x1::vector::reverse<u64>(&mut v0);
        };
        v0
    }

    fun restake_all_original_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: RestakeReceipt, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let RestakeReceipt {  } = arg2;
        0x3::sui_system::request_add_stake_non_entry(arg0, arg1, arg3, arg4)
    }

    public entry fun stake(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::ShareSupply<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::NumberPool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::check_arrived_lock_time<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg3, arg4, arg5, arg7);
        let v2 = 0x3::staking_pool::stake_activation_epoch(&v1);
        if (0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::contains_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui>(arg2)) {
            let v3 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg2);
            if (0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(v3, v2)) {
                0x3::staking_pool::join_staked_sui(0x2::table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(v3, v2), v1);
            } else {
                0x2::table::add<u64, 0x3::staking_pool::StakedSui>(v3, v2, v1);
                if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>())) {
                    0x1::vector::push_back<u64>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>()), v2);
                } else {
                    let v4 = vector[];
                    0x1::vector::push_back<u64>(&mut v4, v2);
                    0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v4);
                };
            };
        } else {
            let v5 = 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg7);
            0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut v5, v2, v1);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v5);
            let v6 = vector[];
            0x1::vector::push_back<u64>(&mut v6, v2);
            0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v6);
        };
        let v7 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::new_share<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1, 0x3::staking_pool::staked_sui_amount(&v1), v0, arg7);
        while (!0x1::vector::is_empty<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&v7)) {
            0x2::transfer::public_transfer<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(0x1::vector::pop_back<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&mut v7), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(v7);
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::update_statistic_for_stake<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg7), v0);
        update_available_amount_for_stake(arg2, v0, arg7);
    }

    fun update_available_amount_for_stake(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Status{dummy_field: false};
        if (0x2::dynamic_field::exists_<Status>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v0)) {
            let v1 = Status{dummy_field: false};
            let v2 = 0x2::dynamic_field::remove<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v1);
            if (0x2::tx_context::epoch(arg2) > v2.last_epoch) {
                v2.available = v2.available + v2.pending;
                v2.pending = arg1;
                v2.last_epoch = 0x2::tx_context::epoch(arg2);
            } else {
                v2.pending = v2.pending + arg1;
            };
            let v3 = Status{dummy_field: false};
            0x2::dynamic_field::add<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v3, v2);
        } else {
            let v4 = StakedSuiStatus{
                available  : 0,
                pending    : arg1,
                last_epoch : 0x2::tx_context::epoch(arg2),
            };
            let v5 = Status{dummy_field: false};
            0x2::dynamic_field::add<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v5, v4);
        };
    }

    fun update_available_amount_for_withdraw(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64) {
        let v0 = Status{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v0);
        assert!(v1.available >= arg1, 2);
        v1.available = v1.available - arg1;
        let v2 = Status{dummy_field: false};
        0x2::dynamic_field::add<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), v2, v1);
    }

    public entry fun withdraw(arg0: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::ShareSupply<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::NumberPool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg3: 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::StakedPoolShare<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::dynamic_field::borrow_mut<0x2::object::ID, u64>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x2::object::uid_to_inner(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2)));
        let v1 = Status{dummy_field: false};
        assert!(v0 <= 0x2::dynamic_field::borrow_mut<Status, StakedSuiStatus>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), v1).available, 2);
        let v2 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::amount<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg3);
        assert!(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::contains_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui>(arg2), 0);
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        let v4 = copy_epoch(arg2);
        let v5 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg2);
        while (0x1::vector::length<u64>(&v4) > 0) {
            let v6 = 0x1::vector::pop_back<u64>(&mut v4);
            let v7 = 0x2::table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(v5, v6);
            if (0x3::staking_pool::staked_sui_amount(v7) > v2) {
                0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, 0x3::staking_pool::split(v7, v2, arg5), arg5));
                0x1::vector::push_back<u64>(&mut v4, 0x3::staking_pool::stake_activation_epoch(v7));
                break
            };
            if (0x3::staking_pool::staked_sui_amount(v7) == v2) {
                0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v5, v6), arg5));
                break
            };
            let v8 = 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v5, v6);
            v2 = v2 - 0x3::staking_pool::staked_sui_amount(&v8);
            0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, v8, arg5));
        };
        let v9 = 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5);
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg5));
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::update_statistic_for_withdraw<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5), v10);
        if (0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::contains_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2)) {
            0x2::coin::join<0x2::sui::SUI>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x2::coin::split<0x2::sui::SUI>(&mut v9, v10 - v0, arg5));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>(), 0x2::coin::split<0x2::sui::SUI>(&mut v9, v10 - v0, arg5));
        };
        0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::staked_share::to_number_pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0, arg3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::uid<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v4);
        update_available_amount_for_withdraw(arg2, v0);
    }

    fun withdraw_all_sui_from_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::Pool<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, RestakeReceipt) {
        let v0 = copy_epoch(arg1);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::borrow_mut_rewards_of_specific_asset<0xbcb4a90f80f8dde034143619bd8fae51f0556f0a08a776cf7ebc384b60027787::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg1);
        while (0x1::vector::length<u64>(&v0) > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v2, 0x1::vector::pop_back<u64>(&mut v0)), arg2));
        };
        let v3 = RestakeReceipt{dummy_field: false};
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), v3)
    }

    // decompiled from Move bytecode v6
}

