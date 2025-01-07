module 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::user {
    struct CreateSpoolAccountEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        created_at: u64,
    }

    struct SpoolAccountUnstakeEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        unstake_amount: u64,
        remaining_amount: u64,
        timestamp: u64,
    }

    struct SpoolAccountStakeEvent has copy, drop {
        sender: address,
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        stake_amount: u64,
        previous_amount: u64,
        timestamp: u64,
    }

    struct SpoolAccountRedeemRewardsEvent has copy, drop {
        sender: address,
        spool_account_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        rewards_pool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        rewards_type: 0x1::type_name::TypeName,
        redeemed_points: u64,
        previous_points: u64,
        rewards_fee: u64,
        rewards: u64,
        total_claimed_rewards: u64,
        total_user_points: u64,
        timestamp: u64,
    }

    struct SpoolRedeemVeSca has copy, drop {
        sender: address,
        ve_sca: 0x2::object::ID,
        targeted_amount: u64,
        redeemed_amount: u64,
        ve_sca_start_time: u64,
        timestamp: u64,
    }

    public fun redeem_rewards<T0, T1>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::RewardsPool<T1>, arg3: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::assert_pool_id<T0>(arg1, arg3);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::assert_spool_id<T1>(arg2, arg1);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg4);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::accrue_points<T0>(arg1, arg3, arg4);
        let v0 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::points<T0>(arg3);
        let (v1, _) = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::redeem_rewards<T0, T1>(arg2, arg3);
        let v3 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::take_rewards<T1>(arg2, v1);
        let v4 = 0x2::balance::value<T1>(&v3);
        let (v5, v6) = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::reward_fee<T1>(arg2);
        let v7 = if (v6 > 0) {
            0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u64::mul_div(v4, v5, v6)
        } else {
            0
        };
        let v8 = SpoolAccountRedeemRewardsEvent{
            sender                : 0x2::tx_context::sender(arg5),
            spool_account_id      : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>>(arg3),
            spool_id              : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1),
            rewards_pool_id       : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::RewardsPool<T1>>(arg2),
            staking_type          : 0x1::type_name::get<T0>(),
            rewards_type          : 0x1::type_name::get<T1>(),
            redeemed_points       : v0 - 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::points<T0>(arg3),
            previous_points       : v0,
            rewards_fee           : v7,
            rewards               : v4,
            total_claimed_rewards : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::claimed_rewards<T1>(arg2),
            total_user_points     : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::total_points<T0>(arg3),
            timestamp             : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEvent>(v8);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v7), arg5), 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::reward_fee_recipient<T1>(arg2));
        };
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun redeem_sca_from_ve_sca(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca, arg2: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg3: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg4: &mut 0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::ScaTreasury, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::SCA> {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        let v0 = 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model::calc_vested_amount(0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::vesting_model(arg2), 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::value(&arg1), 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::mint_timestamp(&arg1), arg5);
        let v1 = SpoolRedeemVeSca{
            sender            : 0x2::tx_context::sender(arg6),
            ve_sca            : 0x2::object::id<0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca>(&arg1),
            targeted_amount   : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::value(&arg1),
            redeemed_amount   : v0,
            ve_sca_start_time : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::mint_timestamp(&arg1),
            timestamp         : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<SpoolRedeemVeSca>(v1);
        let v2 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::redeem_sca_from_ve_sca(arg2, arg3, arg4, arg1, arg5, arg6);
        assert!(0x2::coin::value<0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::SCA>(&v2) == v0, 19);
        v2
    }

    public entry fun stake<T0>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::assert_pool_id<T0>(arg1, arg2);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg4);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::stakes(arg1) + v0 <= 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::max_stakes(arg1), 16);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::stake(arg1, v0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::stake<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(arg3));
        let v1 = SpoolAccountStakeEvent{
            sender           : 0x2::tx_context::sender(arg5),
            spool_account_id : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>>(arg2),
            spool_id         : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            stake_amount     : v0,
            previous_amount  : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::stake_amount<T0>(arg2) - v0,
            timestamp        : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v1);
    }

    public fun unstake<T0>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::assert_pool_id<T0>(arg1, arg2);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg4);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::accrue_points<T0>(arg1, arg2, arg4);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::unstake(arg1, arg3);
        let v0 = SpoolAccountUnstakeEvent{
            spool_account_id : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>>(arg2),
            spool_id         : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            unstake_amount   : arg3,
            remaining_amount : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::stake_amount<T0>(arg2),
            timestamp        : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v0);
        0x2::coin::from_balance<T0>(0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::unstake<T0>(arg2, arg3), arg5)
    }

    public fun new_spool_account<T0>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0> {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::stake_type(arg1), 17);
        let v0 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::new<T0>(arg1, arg3);
        let v1 = CreateSpoolAccountEvent{
            spool_account_id : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>>(&v0),
            spool_id         : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            created_at       : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<CreateSpoolAccountEvent>(v1);
        v0
    }

    public fun redeem_ve_sca_rewards<T0, T1>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::RewardsPool<T1>, arg3: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>, arg4: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg5: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        assert!(0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::is_ve_sca_as_rewards<T1>(arg2), 18);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::assert_pool_id<T0>(arg1, arg3);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::assert_spool_id<T1>(arg2, arg1);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg6);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::accrue_points<T0>(arg1, arg3, arg6);
        let v0 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::points<T0>(arg3);
        let (v1, _) = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::redeem_rewards<T0, T1>(arg2, arg3);
        let (v3, v4) = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::reward_fee<T1>(arg2);
        let v5 = if (v4 > 0 && v3 > 0) {
            0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u64::mul_div(v1, v3, v4)
        } else {
            0
        };
        let v6 = SpoolAccountRedeemRewardsEvent{
            sender                : 0x2::tx_context::sender(arg7),
            spool_account_id      : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>>(arg3),
            spool_id              : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1),
            rewards_pool_id       : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::RewardsPool<T1>>(arg2),
            staking_type          : 0x1::type_name::get<T0>(),
            rewards_type          : 0x1::type_name::get<T1>(),
            redeemed_points       : v0 - 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::points<T0>(arg3),
            previous_points       : v0,
            rewards_fee           : v5,
            rewards               : v1,
            total_claimed_rewards : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::claimed_rewards<T1>(arg2),
            total_user_points     : 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::total_points<T0>(arg3),
            timestamp             : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEvent>(v6);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool::mint_ve_sca(arg4, arg5, v1 - v5, arg6, arg7)
    }

    public entry fun update_points<T0>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::Version, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg2: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>, arg3: &0x2::clock::Clock) {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::version::assert_current_version(arg0);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::accrue_points(arg1, arg3);
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::accrue_points<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

