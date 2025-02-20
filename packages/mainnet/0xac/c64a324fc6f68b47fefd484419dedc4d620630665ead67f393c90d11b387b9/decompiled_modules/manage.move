module 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::manage {
    public fun create_incentive_v3(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::create_incentive_v3(arg1);
    }

    public fun withdraw_borrow_fee<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::withdraw_borrow_fee<T0>(arg1, arg2, arg4), arg4), arg3);
    }

    public fun create_flash_loan_asset<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg3: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_reserves_count(arg2), 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::reserve_not_found());
        let v0 = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg2, arg4);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == v0, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::invalid_coin_type());
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::create_asset(arg1, arg4, v0, 0x2::object::uid_to_address(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::pool::uid<T0>(arg3)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun create_flash_loan_config(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::create_config(arg1);
    }

    public fun create_incentive_v3_pool<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::create_pool<T0>(arg1, arg2, arg3, arg4);
    }

    public fun create_incentive_v3_reward_fund<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::create_reward_fund<T0>(arg1);
    }

    public fun create_incentive_v3_rule<T0, T1>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::create_rule<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun deposit_incentive_v3_reward_fund<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::RewardFund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::invalid_amount());
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::deposit_reward_fund<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun disable_incentive_v3_by_rule_id<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::set_enable_by_rule_id<T0>(arg1, arg2, false, arg3);
    }

    public fun enable_incentive_v3_by_rule_id<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::set_enable_by_rule_id<T0>(arg1, arg2, true, arg3);
    }

    public fun incentive_v3_version_migrate(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive) {
        assert!(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::version(arg1) < 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::version::this_version(), 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::incorrect_version());
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::version_migrate(arg1, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::version::this_version());
    }

    public fun set_flash_loan_asset_max<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: u64) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::set_asset_max(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_min<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: u64) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::set_asset_min(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_rate_to_supplier<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: u64) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::set_asset_rate_to_supplier(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_rate_to_treasury<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: u64) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::set_asset_rate_to_treasury(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_incentive_v3_borrow_fee_rate(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::set_borrow_fee_rate(arg1, arg2, arg3);
    }

    public fun set_incentive_v3_max_reward_rate_by_rule_id<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg2: address, arg3: u64, arg4: u64) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::set_max_reward_rate_by_rule_id<T0>(arg1, arg2, arg3, arg4);
    }

    public fun set_incentive_v3_reward_rate_by_rule_id<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v2::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::Incentive, arg3: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::set_reward_rate_by_rule_id<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun withdraw_incentive_v3_reward_fund<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::RewardFund<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::incentive_v3::withdraw_reward_fund<T0>(arg1, arg2, arg4), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

