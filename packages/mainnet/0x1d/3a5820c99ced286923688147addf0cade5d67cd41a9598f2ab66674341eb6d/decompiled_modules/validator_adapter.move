module 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::validator_adapter {
    struct RestakeReceipt {
        dummy_field: bool,
    }

    public entry fun allocate_reward(arg0: &0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::GlobalConfig, arg1: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::ShareSupply<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg4: address, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<u64>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::current_round<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3)), 1);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::check_arrived_reward_time<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg7);
        let (v0, v1) = withdraw_all_sui_from_validator(arg2, arg3, arg8);
        let v2 = v0;
        if (0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::contains_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3)) {
            let v3 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
            0x2::coin::join<0x2::sui::SUI>(&mut v2, 0x2::coin::split<0x2::sui::SUI>(v3, 0x2::coin::value<0x2::sui::SUI>(v3), arg8));
        };
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::active_supply<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1), arg8);
        let v5 = restake_all_original_sui(arg2, v4, v1, arg4, arg8);
        let v6 = vector[];
        0x1::vector::push_back<u64>(&mut v6, 0x3::staking_pool::stake_activation_epoch(&v5));
        0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v6);
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg3), 0x3::staking_pool::stake_activation_epoch(&v5), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x2::coin::value<0x2::sui::SUI>(&v2) * 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::platform_ratio<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3) / 10000, arg8), 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x2::coin::value<0x2::sui::SUI>(&v2) * 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::allocate_gas_payer_ratio<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3) / 10000, arg8), 0x2::tx_context::sender(arg8));
        let v7 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::current_round<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
        0x2::dynamic_field::add<u64, u64>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), v7, 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::drand_lib::random_index_range(arg5, arg6, 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::total_supply<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1)));
        let v8 = v7 - 1;
        let v9;
        loop {
            v9 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::extract_previous_rewards<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, v8);
            if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&v9)) {
                break
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v2, 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v9));
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
            v8 = v8 - 1;
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v9);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::put_current_round_reward_to_claimable<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, v2);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::next_round<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::update_time<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg7);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::add_expired_data<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg7);
    }

    public entry fun claim_reward(arg0: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: vector<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::check_claim_expired<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1, arg3);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::check_is_claimed<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::check_round_could_claim_reward<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v0 = *0x2::dynamic_field::borrow<u64, u64>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2)) {
            let v2 = 0x1::vector::borrow<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2, v1);
            if (v0 >= 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::start_num<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(v2) && v0 <= 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::end_num<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::extract_round_claimable_reward<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1), 0x2::tx_context::sender(arg4));
                0x2::table::add<u64, address>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_claimed<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1, 0x2::tx_context::sender(arg4));
                break
            };
            v1 = v1 + 1;
        };
        loop {
            0x2::transfer::public_transfer<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(0x1::vector::pop_back<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg2), 0x2::tx_context::sender(arg4));
            if (0x1::vector::is_empty<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&arg2)) {
                break
            };
        };
        0x1::vector::destroy_empty<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(arg2);
    }

    fun copy_epoch(arg0: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>) : vector<u64> {
        0x2::dynamic_field::remove<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg0), 0x1::type_name::get<0x3::staking_pool::StakedSui>())
    }

    fun restake_all_original_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: RestakeReceipt, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let RestakeReceipt {  } = arg2;
        0x3::sui_system::request_add_stake_non_entry(arg0, arg1, arg3, arg4)
    }

    public entry fun stake(arg0: &0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::GlobalConfig, arg1: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::ShareSupply<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::NumberPool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::check_arrived_lock_time<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg7);
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg4, arg5, arg6, arg8);
        let v1 = 0x3::staking_pool::stake_activation_epoch(&v0);
        if (0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::contains_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui>(arg3)) {
            let v2 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg3);
            if (0x2::table::contains<u64, 0x3::staking_pool::StakedSui>(v2, v1)) {
                0x3::staking_pool::join_staked_sui(0x2::table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(v2, v1), v0);
            } else {
                0x2::table::add<u64, 0x3::staking_pool::StakedSui>(v2, v1, v0);
                if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>())) {
                    0x1::vector::push_back<u64>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>()), v1);
                } else {
                    let v3 = vector[];
                    0x1::vector::push_back<u64>(&mut v3, v1);
                    0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v3);
                };
            };
        } else {
            let v4 = 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg8);
            0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut v4, v1, v0);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v4);
            let v5 = vector[];
            0x1::vector::push_back<u64>(&mut v5, v1);
            0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg3), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v5);
        };
        let v6 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::new_share<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg5), arg8);
        while (!0x1::vector::is_empty<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&v6)) {
            0x2::transfer::public_transfer<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(0x1::vector::pop_back<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(&mut v6), 0x2::tx_context::sender(arg8));
        };
        0x1::vector::destroy_empty<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>>(v6);
    }

    public entry fun withdraw(arg0: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::ShareSupply<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::NumberPool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg3: 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::StakedPoolShare<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::amount<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(&arg3);
        assert!(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::contains_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui>(arg2), 0);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = copy_epoch(arg2);
        let v3 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg2);
        while (0x1::vector::length<u64>(&v2) > 0) {
            let v4 = 0x1::vector::pop_back<u64>(&mut v2);
            let v5 = 0x2::table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(v3, v4);
            if (0x3::staking_pool::staked_sui_amount(v5) > v0) {
                0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, 0x3::staking_pool::split(v5, v0, arg5), arg5));
                0x1::vector::push_back<u64>(&mut v2, 0x3::staking_pool::stake_activation_epoch(v5));
                break
            };
            if (0x3::staking_pool::staked_sui_amount(v5) == v0) {
                0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v3, v4), arg5));
                break
            };
            let v6 = 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v3, v4);
            v0 = v0 - 0x3::staking_pool::staked_sui_amount(&v6);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg4, v6, arg5));
        };
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg5));
        if (0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::contains_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2)) {
            0x2::coin::join<0x2::sui::SUI>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x2::coin::value<0x2::sui::SUI>(&v7) - v0, arg5));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>(), 0x2::coin::split<0x2::sui::SUI>(&mut v7, 0x2::coin::value<0x2::sui::SUI>(&v7) - v0, arg5));
        };
        0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::staked_share::to_number_pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0, arg3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, vector<u64>>(0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::uid<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), v2);
    }

    fun withdraw_all_sui_from_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::Pool<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, RestakeReceipt) {
        let v0 = copy_epoch(arg1);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::borrow_mut_rewards_of_specific_asset<0x1d3a5820c99ced286923688147addf0cade5d67cd41a9598f2ab66674341eb6d::pool::VALIDATOR, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>, 0x3::staking_pool::StakedSui, 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>>(arg1);
        while (0x1::vector::length<u64>(&v0) > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(v2, 0x1::vector::pop_back<u64>(&mut v0)), arg2));
        };
        let v3 = RestakeReceipt{dummy_field: false};
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), v3)
    }

    // decompiled from Move bytecode v6
}

