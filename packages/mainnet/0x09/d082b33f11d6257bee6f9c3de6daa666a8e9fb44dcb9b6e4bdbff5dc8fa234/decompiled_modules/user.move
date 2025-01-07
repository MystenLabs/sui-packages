module 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::user {
    struct CreateSpoolAccountEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        spool_account_key_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        created_at: u64,
    }

    struct SpoolAccountUnstakeEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        staked_amount: u64,
        earning_weight_list: vector<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::EarningWeight>,
        ve_sca_amount: u64,
        timestamp: u64,
    }

    struct SpoolAccountStakeEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        staked_amount: u64,
        earning_weight_list: vector<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::EarningWeight>,
        ve_sca_amount: u64,
        timestamp: u64,
    }

    struct DeactivateBoostEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        staked_amount: u64,
        earning_weight_list: vector<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::EarningWeight>,
        prev_ve_sca_key_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct RefreshInactiveBoostEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        staked_amount: u64,
        earning_weight_list: vector<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::EarningWeight>,
        prev_ve_sca_key_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SpoolAccountRedeemRewardsEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        rewards_type: 0x1::type_name::TypeName,
        redeemed_points: u64,
        previous_points: u64,
        rewards_fee: u64,
        rewards: u64,
        timestamp: u64,
    }

    struct SpoolAccountCreationHotPotato {
        spool_account_id: 0x2::object::ID,
    }

    public fun redeem_rewards<T0, T1>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_ownership<T0>(arg2, arg3);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_pool_id<T0>(arg1, arg2);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::points(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::spool_account_point<T0>(arg2, 0x1::type_name::get<T1>()));
        let v1 = 0x2::math::min(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::remaining_reward<T1>(arg1), v0);
        let v2 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::redeem_rewards<T0, T1>(arg1, arg2, v1);
        let v3 = 0x2::balance::value<T1>(&v2);
        let (v4, v5) = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::reward_fee(arg1);
        let v6 = if (v5 > 0) {
            0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(v3, v4, v5)
        } else {
            0
        };
        let v7 = SpoolAccountRedeemRewardsEvent{
            spool_account_id : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id         : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            rewards_type     : 0x1::type_name::get<T1>(),
            redeemed_points  : v1,
            previous_points  : v0,
            rewards_fee      : v6,
            rewards          : v3,
            timestamp        : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEvent>(v7);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v6), arg5), 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::reward_fee_recipient(arg1));
        };
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public entry fun stake<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == false, 20);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) + v0;
        update_all_weighted_amount_without_ve_sca<T0>(arg1, arg2, v1);
        stake_internal<T0>(arg1, arg2, arg3);
        let v2 = SpoolAccountStakeEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            deposit_amount      : v0,
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            ve_sca_amount       : 0,
            timestamp           : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v2);
    }

    public fun unstake<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg5);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg5);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == false, 20);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) >= arg4, 18);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) - arg4;
        update_all_weighted_amount_without_ve_sca<T0>(arg1, arg2, v0);
        let v1 = unstake_internal<T0>(arg1, arg2, arg3, arg4);
        let v2 = SpoolAccountUnstakeEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            withdraw_amount     : arg4,
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            ve_sca_amount       : 0,
            timestamp           : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg6)
    }

    fun calc_base_weighted_amount(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(arg2, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::base_weight(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::spool_point(arg0, arg1)), 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::weight_scale())
    }

    fun calc_weighted_amount(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg2: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg5: u64, arg6: u64, arg7: 0x1::type_name::TypeName, arg8: &0x2::clock::Clock) : u64 {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::refresh(arg1, arg2, arg8);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::spool_point(arg0, arg7);
        0x2::math::min(arg5, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(arg5, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::base_weight(v0), 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::weight_scale()) + 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(arg6, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg4), arg3, arg8), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::total_ve_sca_amount(arg2, arg8)), 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::weight_scale() - 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::base_weight(v0), 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::weight_scale()))
    }

    public fun complete_spool_account_creation<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg2: SpoolAccountCreationHotPotato) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        let SpoolAccountCreationHotPotato { spool_account_id: v0 } = arg2;
        assert!(v0 == 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(&arg1), 19);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::share_spool_account<T0>(arg1);
    }

    public fun deactivate_boost<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg4: &0x2::clock::Clock) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_pool_id<T0>(arg1, arg2);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_ownership<T0>(arg2, arg3);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == true, 23);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::get_binded_ve_sca<T0>(arg2);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::unbind_ve_sca_from_spool_account(arg1, v0, 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2));
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::unbind_ve_sca<T0>(arg2);
        let v1 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2);
        update_all_weighted_amount_without_ve_sca<T0>(arg1, arg2, v1);
        let v2 = DeactivateBoostEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            prev_ve_sca_key_id  : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(v0),
            timestamp           : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<DeactivateBoostEvent>(v2);
    }

    public fun new_spool_account<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, SpoolAccountCreationHotPotato) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::stake_type(arg1), 17);
        let (v0, v1) = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::new<T0>(arg1, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(&v3);
        let v5 = CreateSpoolAccountEvent{
            spool_account_id     : v4,
            spool_id             : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            spool_account_key_id : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey>(&v2),
            staking_type         : 0x1::type_name::get<T0>(),
            created_at           : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<CreateSpoolAccountEvent>(v5);
        let v6 = SpoolAccountCreationHotPotato{spool_account_id: v4};
        (v3, v2, v6)
    }

    public entry fun new_spool_account_entry<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = new_spool_account<T0>(arg0, arg1, arg2, arg3);
        complete_spool_account_creation<T0>(arg0, v0, v2);
        0x2::transfer::public_transfer<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun refresh_inactive_boost<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg4: &0x2::clock::Clock) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_pool_id<T0>(arg1, arg2);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == true, 23);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::get_binded_ve_sca<T0>(arg2);
        assert!(0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(*0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::as_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v0), arg3, arg4) == 0, 24);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::unbind_ve_sca_from_spool_account(arg1, v0, 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2));
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::unbind_ve_sca<T0>(arg2);
        let v1 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2);
        update_all_weighted_amount_without_ve_sca<T0>(arg1, arg2, v1);
        let v2 = RefreshInactiveBoostEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            prev_ve_sca_key_id  : *0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::as_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v0),
            timestamp           : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<RefreshInactiveBoostEvent>(v2);
    }

    fun stake_internal<T0>(arg0: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_pool_id<T0>(arg0, arg1);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::stakes(arg0) + 0x2::coin::value<T0>(&arg2) <= 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::max_stakes(arg0), 16);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake<T0>(arg1, arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun stake_with_ve_sca<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg6: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg7: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg9);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg9);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_ownership<T0>(arg2, arg3);
        if (0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == false) {
            assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::is_ve_sca_binded(arg1, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::new<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7)) == false, 22);
            0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::bind_ve_sca_to_spool_account(arg1, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::new<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7), 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2));
            0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::bind_ve_sca<T0>(arg2, 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::new<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7));
        };
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::get_binded_ve_sca<T0>(arg2)) == 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7), 21);
        let v0 = 0x2::coin::value<T0>(&arg8);
        let v1 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) + v0;
        let v2 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::stakes(arg1) + v0;
        update_all_weighted_amount_with_ve_sca<T0>(arg1, arg2, arg4, arg5, arg6, arg7, v1, v2, arg9);
        stake_internal<T0>(arg1, arg2, arg8);
        let v3 = SpoolAccountStakeEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            deposit_amount      : v0,
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            ve_sca_amount       : 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7), arg6, arg9),
            timestamp           : 0x2::clock::timestamp_ms(arg9) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v3);
    }

    fun unstake_internal<T0>(arg0: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg2: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg3: u64) : 0x2::balance::Balance<T0> {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_pool_id<T0>(arg0, arg1);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::assert_ownership<T0>(arg1, arg2);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::unstake<T0>(arg1, arg0, arg3)
    }

    public fun unstake_with_ve_sca<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccountKey, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg5: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg6: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg7: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg9);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg9);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_ve_sca_key_binded<T0>(arg2) == true, 23);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::get_binded_ve_sca<T0>(arg2)) == 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7), 21);
        assert!(0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) >= arg8, 18);
        let v0 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2) - arg8;
        let v1 = 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::stakes(arg1) - arg8;
        update_all_weighted_amount_with_ve_sca<T0>(arg1, arg2, arg4, arg5, arg6, arg7, v0, v1, arg9);
        let v2 = unstake_internal<T0>(arg1, arg2, arg3, arg8);
        let v3 = SpoolAccountUnstakeEvent{
            spool_account_id    : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>>(arg2),
            spool_id            : 0x2::object::id<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool>(arg1),
            staking_type        : 0x1::type_name::get<T0>(),
            withdraw_amount     : arg8,
            staked_amount       : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::stake_amount<T0>(arg2),
            earning_weight_list : 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::earning_weight_list<T0>(arg2),
            ve_sca_amount       : 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg7), arg6, arg9),
            timestamp           : 0x2::clock::timestamp_ms(arg9) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v3);
        0x2::coin::from_balance<T0>(v2, arg10)
    }

    fun update_all_weighted_amount_with_ve_sca<T0>(arg0: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg2: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg3: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg5: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = *0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::points_list(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (!0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_spool_account_point_exist<T0>(arg1, v2)) {
                0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::new_spool_account_point<T0>(arg1, arg0, v2);
            };
            0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::update_weighted_amount<T0>(arg1, arg0, v2, calc_weighted_amount(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v2, arg8));
            v1 = v1 + 1;
        };
    }

    fun update_all_weighted_amount_without_ve_sca<T0>(arg0: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg2: u64) {
        let v0 = *0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::points_list(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (!0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::is_spool_account_point_exist<T0>(arg1, v2)) {
                0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::new_spool_account_point<T0>(arg1, arg0, v2);
            };
            0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::update_weighted_amount<T0>(arg1, arg0, v2, calc_base_weighted_amount(arg0, v2, arg2));
            v1 = v1 + 1;
        };
    }

    public entry fun update_points<T0>(arg0: &0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::SpoolConfig, arg1: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::Spool, arg2: &mut 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::SpoolAccount<T0>, arg3: &0x2::clock::Clock) {
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_config::assert_version_and_status(arg0);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool::accrue_points(arg1, arg3);
        0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool_account::accrue_points<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

