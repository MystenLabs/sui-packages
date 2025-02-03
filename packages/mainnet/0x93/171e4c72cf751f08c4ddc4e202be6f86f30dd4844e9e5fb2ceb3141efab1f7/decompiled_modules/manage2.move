module 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::manage2 {
    public fun create_incentive_v4(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::create_incentive_v4(arg1);
    }

    public fun withdraw_borrow_fee<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::StorageAdminCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::withdraw_borrow_fee<T0>(arg1, arg2, arg4), arg4), arg3);
    }

    public fun create_incentive_v4_pool<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::create_pool<T0>(arg1, arg2, arg3, arg4);
    }

    public fun create_incentive_v4_reward_fund<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::create_reward_fund<T0>(arg1);
    }

    public fun create_incentive_v4_rule<T0, T1>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::create_rule<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun deposit_incentive_v4_reward_fund<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::RewardFund<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::invalid_amount());
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::deposit_reward_fund<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun disable_incentive_v4_by_rule_id<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::set_enable_by_rule_id<T0>(arg1, arg2, false, arg3);
    }

    public fun enable_incentive_v4_by_rule_id<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::set_enable_by_rule_id<T0>(arg1, arg2, true, arg3);
    }

    public fun incentive_v4_version_migrate(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::StorageAdminCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive) {
        assert!(0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::version(arg1) < 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::version::this_version(), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::incorrect_version());
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::version_migrate(arg1, 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::version::this_version());
    }

    public fun set_incentive_v4_borrow_fee_rate(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::StorageAdminCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::set_borrow_fee_rate(arg1, arg2, arg3);
    }

    public fun set_incentive_v4_max_reward_rate_by_rule_id<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg2: address, arg3: u64, arg4: u64) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::set_max_reward_rate_by_rule_id<T0>(arg1, arg2, arg3, arg4);
    }

    public fun set_incentive_v4_reward_rate_by_rule_id<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::Incentive, arg3: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::storage::Storage, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::set_reward_rate_by_rule_id<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun withdraw_incentive_v4_reward_fund<T0>(arg0: &0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v2::OwnerCap, arg1: &mut 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::RewardFund<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::incentive_v4::withdraw_reward_fund<T0>(arg1, arg2, arg4), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

