module 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::validator_adapter {
    public entry fun allocate_rewards(arg0: &0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::GlobalConfig, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::Pool<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::check_arrived_reward_time(arg2, arg6);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::pool_asset<0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg2), arg7), arg7);
        0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::pool_asset<0x2::sui::SUI, 0x2::coin::Coin<0x2::sui::SUI>>(arg2));
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x3::staking_pool::StakedSui>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg2), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::total_amount<0x2::sui::SUI>(arg2), arg7), arg3, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::platform_ratio<0x2::sui::SUI>(arg2) / 10000, arg7), 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::platform_address(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::allocate_gas_payer_ratio<0x2::sui::SUI>(arg2) / 10000, arg7), 0x2::tx_context::sender(arg7));
        let v1 = 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::user_by_idx<0x2::sui::SUI>(arg2, 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::drand_lib::random_index_range(arg4, arg5, 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::staked_user_amount<0x2::sui::SUI>(arg2)));
        0x2::dynamic_field::add<u64, address>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg2), 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::current_round<0x2::sui::SUI>(arg2), v1);
        if (0x2::dynamic_field::exists_<address>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg2), v1)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<address, 0x2::coin::Coin<0x2::sui::SUI>>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg2), v1), v0);
        } else {
            0x2::dynamic_field::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg2), v1, v0);
        };
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::next_round<0x2::sui::SUI>(arg2);
    }

    public entry fun claim_reward<T0>(arg0: &mut 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<address>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<T0>(arg0), 0x2::tx_context::sender(arg1)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_object_field::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<T0>(arg0), 0x2::tx_context::sender(arg1)), 0x2::tx_context::sender(arg1));
    }

    public entry fun stake(arg0: &mut 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::Pool<0x2::sui::SUI>, arg1: &0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::PoolList, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::include_pool_list_check<0x2::sui::SUI>(arg0, arg1);
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::check_pool_type<0x2::sui::SUI>(arg0, b"to_validator");
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x3::staking_pool::StakedSui>())) {
            0x3::staking_pool::join_staked_sui(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::borrow_mut_pool_asset<0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg0), 0x3::sui_system::request_add_stake_non_entry(arg2, arg3, arg4, arg5));
        } else {
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x3::staking_pool::StakedSui>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x3::staking_pool::StakedSui>(), 0x3::sui_system::request_add_stake_non_entry(arg2, arg3, arg4, arg5));
        };
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::update_stake_info<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg5), v0, true);
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::update_validator_table_data_on_pool(arg0, arg4, v0, true, arg5);
    }

    public entry fun withdraw(arg0: &mut 0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::Pool<0x2::sui::SUI>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::check_user_in_pool<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg3));
        0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::check_staked_amount<0x2::sui::SUI>(arg0, 0x2::tx_context::sender(arg3), arg2);
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x3::staking_pool::StakedSui>()), 0);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x3::staking_pool::split(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::borrow_mut_pool_asset<0x2::sui::SUI, 0x3::staking_pool::StakedSui>(arg0), arg2, arg3), arg3), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>())) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>()), 0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) - arg2, arg3));
        } else {
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<0x2::sui::SUI>>(0x7e309f15fc368777ccb40349f87f1f278b40f6eb248f6c843323d0394bbfc5b5::pool::uid<0x2::sui::SUI>(arg0), 0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>(), 0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) - arg2, arg3));
        };
    }

    // decompiled from Move bytecode v6
}

