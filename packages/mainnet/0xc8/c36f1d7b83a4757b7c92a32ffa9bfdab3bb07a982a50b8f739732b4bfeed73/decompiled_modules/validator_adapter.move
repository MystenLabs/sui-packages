module 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::validator_adapter {
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

    struct EpochTable has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun allocate_reward(arg0: &0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::GlobalConfig, arg1: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::ShareSupply<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::borrow_mut_rewards<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(v0, 0x2::balance::value<0x2::sui::SUI>(v0));
        let v2 = EpochTable{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::remove<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3), v2);
        assert!(!0x2::dynamic_field::exists_<u64>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3), 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::current_round<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3)), 1);
        let v4 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::extract_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg3);
        update_available_amount_for_stake(arg3, 0, arg9);
        let v5 = Status{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3), v5);
        assert!(v6.last_epoch < 0x2::tx_context::epoch(arg9), 3);
        assert!(v6.pending == 0, 3);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::check_arrived_reward_time<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, arg8);
        update_available_amount_for_withdraw(arg3, v6.available);
        let v7 = &mut v4;
        let v8 = &mut v3;
        let (v9, v10) = withdraw_all_sui_from_validator(v7, v8, arg2, arg9);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, v9);
        let v11 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::current_total_amount<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3);
        update_available_amount_for_stake(arg3, v11, arg9);
        let v12 = &mut v4;
        let v13 = &mut v3;
        restake_all_original_sui(v12, v13, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v11), v10, arg4, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(&v1) * 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::platform_ratio<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3) / 10000), arg9), 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(&v1) * 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::allocate_gas_payer_ratio<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3) / 10000), arg9), 0x2::tx_context::sender(arg9));
        let v14 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::current_round<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3);
        0x2::dynamic_field::add<u64, u64>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3), v14, 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::random_lib::verify_and_random<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, arg5, arg6, arg7, 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::total_supply<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg1)));
        let v15 = v14 - 1;
        let v16;
        loop {
            v16 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::extract_previous_rewards<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, v15);
            if (0x1::option::is_none<0x2::balance::Balance<0x2::sui::SUI>>(&v16)) {
                break
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x1::option::extract<0x2::balance::Balance<0x2::sui::SUI>>(&mut v16));
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v16);
            v15 = v15 - 1;
        };
        0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v16);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::put_current_round_reward_to_claimable<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, v1);
        let v17 = EpochTable{dummy_field: false};
        0x2::dynamic_object_field::add<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3), v17, v3);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::reput_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg3, v4);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::next_round<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::update_time<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, arg8);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::add_expired_data<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg3);
    }

    public entry fun claim_reward(arg0: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg1: u64, arg2: vector<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::check_claim_expired<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1, arg3);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::check_is_claimed<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::check_round_could_claim_reward<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&arg2, v1);
            if (v0 >= 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::start_num<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(v2) && v0 <= 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::end_num<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::extract_round_claimable_reward<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1), arg4), 0x2::tx_context::sender(arg4));
                0x2::table::add<u64, address>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::borrow_mut_claimed<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), arg1, 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(0x1::vector::pop_back<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(arg2);
    }

    fun restake_all_original_sui(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x2::table::Table<u64, u64>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: RestakeReceipt, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let RestakeReceipt {  } = arg4;
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg6), arg5, arg6);
        0x1::vector::push_back<0x3::staking_pool::StakedSui>(arg0, v0);
        0x2::table::add<u64, u64>(arg1, 0x3::staking_pool::stake_activation_epoch(&v0), 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0) - 1);
    }

    public entry fun stake(arg0: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::ShareSupply<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg1: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::NumberPool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg2: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::check_arrived_lock_time<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2, arg6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v1 = 0x3::sui_system::request_add_stake_non_entry(arg3, arg4, arg5, arg7);
        let v2 = 0x3::staking_pool::stake_activation_epoch(&v1);
        if (0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::contains_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2)) {
            let v3 = EpochTable{dummy_field: false};
            let v4 = 0x2::dynamic_object_field::remove<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v3);
            let v5 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::extract_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2);
            if (0x2::table::contains<u64, u64>(&v4, v2)) {
                0x3::staking_pool::join_staked_sui(0x1::vector::borrow_mut<0x3::staking_pool::StakedSui>(&mut v5, *0x2::table::borrow<u64, u64>(&v4, v2)), v1);
            } else {
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v5, v1);
                0x2::table::add<u64, u64>(&mut v4, v2, 0x1::vector::length<0x3::staking_pool::StakedSui>(&v5));
            };
            let v6 = EpochTable{dummy_field: false};
            0x2::dynamic_object_field::add<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v6, v4);
            0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::reput_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2, v5);
        } else {
            0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::create_proof_container<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2, true, v1);
            let v7 = 0x2::table::new<u64, u64>(arg7);
            0x2::table::add<u64, u64>(&mut v7, v2, 0);
            let v8 = EpochTable{dummy_field: false};
            0x2::dynamic_object_field::add<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v8, v7);
        };
        let v9 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::new_share<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1, 0x3::staking_pool::staked_sui_amount(&v1), v0, arg7);
        while (!0x1::vector::is_empty<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&v9)) {
            0x2::transfer::public_transfer<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(0x1::vector::pop_back<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(&mut v9), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>>(v9);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::update_statistic_for_stake<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg7), v0);
        update_available_amount_for_stake(arg2, v0, arg7);
    }

    fun update_available_amount_for_stake(arg0: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Status{dummy_field: false};
        if (0x2::dynamic_field::exists_<Status>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v0)) {
            let v1 = Status{dummy_field: false};
            let v2 = 0x2::dynamic_field::remove<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v1);
            if (0x2::tx_context::epoch(arg2) > v2.last_epoch) {
                v2.available = v2.available + v2.pending;
                v2.pending = arg1;
                v2.last_epoch = 0x2::tx_context::epoch(arg2);
            } else {
                v2.pending = v2.pending + arg1;
            };
            let v3 = Status{dummy_field: false};
            0x2::dynamic_field::add<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v3, v2);
        } else {
            let v4 = StakedSuiStatus{
                available  : 0,
                pending    : arg1,
                last_epoch : 0x2::tx_context::epoch(arg2),
            };
            let v5 = Status{dummy_field: false};
            0x2::dynamic_field::add<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v5, v4);
        };
    }

    fun update_available_amount_for_withdraw(arg0: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg1: u64) {
        let v0 = Status{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v0);
        assert!(v1.available >= arg1, 2);
        v1.available = v1.available - arg1;
        let v2 = Status{dummy_field: false};
        0x2::dynamic_field::add<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg0), v2, v1);
    }

    public entry fun withdraw(arg0: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::ShareSupply<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg1: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::NumberPool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg2: &mut 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::Pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg3: 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::StakedPoolShare<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2);
        let v1 = *0x2::dynamic_field::borrow_mut<0x2::object::ID, u64>(v0, 0x2::object::uid_to_inner(v0));
        let v2 = Status{dummy_field: false};
        assert!(v1 <= 0x2::dynamic_field::borrow_mut<Status, StakedSuiStatus>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v2).available, 2);
        let v3 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::amount<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(&arg3);
        assert!(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::contains_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2), 0);
        let v4 = EpochTable{dummy_field: false};
        let v5 = 0x2::dynamic_object_field::remove<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v4);
        let v6 = 0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::extract_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2);
        let v7 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<0x3::staking_pool::StakedSui>(&v6) > 0) {
            let v8 = 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v6);
            let v9 = 0x3::staking_pool::stake_activation_epoch(&v8);
            if (0x3::staking_pool::staked_sui_amount(&v8) > v3) {
                0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, 0x3::staking_pool::split(&mut v8, v3, arg5), arg5));
                0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v6, v8);
                break
            };
            if (0x3::staking_pool::staked_sui_amount(&v8) == v3) {
                0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, v8, arg5));
                0x2::table::remove<u64, u64>(&mut v5, v9);
                break
            };
            v3 = v3 - 0x3::staking_pool::staked_sui_amount(&v8);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, v8, arg5));
            0x2::table::remove<u64, u64>(&mut v5, v9);
        };
        let v10 = 0x2::balance::split<0x2::sui::SUI>(&mut v7, 0x2::balance::value<0x2::sui::SUI>(&v7) - v1);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::update_statistic_for_withdraw<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg5), 0x2::balance::value<0x2::sui::SUI>(&v7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg5), 0x2::tx_context::sender(arg5));
        if (0x2::balance::value<0x2::sui::SUI>(&v10) > 0) {
            0x2::balance::join<0x2::sui::SUI>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::borrow_mut_rewards<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v10);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        };
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::staked_share::to_number_pool<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg1, arg0, arg3);
        update_available_amount_for_withdraw(arg2, v1);
        let v11 = EpochTable{dummy_field: false};
        0x2::dynamic_object_field::add<EpochTable, 0x2::table::Table<u64, u64>>(0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::uid<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI>(arg2), v11, v5);
        0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::reput_vec_proof<0xc8c36f1d7b83a4757b7c92a32ffa9bfdab3bb07a982a50b8f739732b4bfeed73::pool::VALIDATOR, 0x2::sui::SUI, 0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2, v6);
    }

    fun withdraw_all_sui_from_validator(arg0: &mut vector<0x3::staking_pool::StakedSui>, arg1: &mut 0x2::table::Table<u64, u64>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, RestakeReceipt) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (0x1::vector::length<0x3::staking_pool::StakedSui>(arg0) > 0) {
            let v1 = 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(arg0);
            0x2::table::remove<u64, u64>(arg1, 0x3::staking_pool::stake_activation_epoch(&v1));
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg2, v1, arg3));
        };
        let v2 = RestakeReceipt{dummy_field: false};
        (v0, v2)
    }

    // decompiled from Move bytecode v6
}

