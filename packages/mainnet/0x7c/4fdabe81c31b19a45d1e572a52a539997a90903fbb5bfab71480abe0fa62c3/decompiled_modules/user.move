module 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user {
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
        rewards: u64,
        total_claimed_rewards: u64,
        total_user_points: u64,
        timestamp: u64,
    }

    struct SpoolAccountRedeemRewardsEventV2 has copy, drop {
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

    public fun redeem_rewards<T0, T1>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::assert_pool_id<T0>(arg0, arg2);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::assert_spool_id<T1>(arg1, arg0);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::accrue_points(arg0, arg3);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::accrue_points<T0>(arg0, arg2, arg3);
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::points<T0>(arg2);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::redeem_rewards<T0, T1>(arg1, arg2);
        let v2 = 0x2::balance::value<T1>(&v1);
        let (v3, v4) = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::reward_fee<T1>(arg1);
        let v5 = if (v4 > 0) {
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::u64::mul_div(v2, v3, v4)
        } else {
            0
        };
        let v6 = SpoolAccountRedeemRewardsEventV2{
            sender                : 0x2::tx_context::sender(arg4),
            spool_account_id      : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg2),
            spool_id              : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg0),
            rewards_pool_id       : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>>(arg1),
            staking_type          : 0x1::type_name::get<T0>(),
            rewards_type          : 0x1::type_name::get<T1>(),
            redeemed_points       : v0 - 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::points<T0>(arg2),
            previous_points       : v0,
            rewards_fee           : v5,
            rewards               : v2,
            total_claimed_rewards : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::claimed_rewards<T1>(arg1),
            total_user_points     : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::total_points<T0>(arg2),
            timestamp             : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEventV2>(v6);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1, v5), arg4), 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::reward_fee_recipient<T1>(arg1));
        };
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public entry fun stake<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::assert_pool_id<T0>(arg0, arg1);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::accrue_points(arg0, arg3);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::accrue_points<T0>(arg0, arg1, arg3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::stakes(arg0) + v0 <= 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::max_stakes(arg0), 16);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::stake(arg0, v0);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
        let v1 = SpoolAccountStakeEvent{
            sender           : 0x2::tx_context::sender(arg4),
            spool_account_id : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg1),
            spool_id         : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            stake_amount     : v0,
            previous_amount  : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<T0>(arg1) - v0,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v1);
    }

    public fun unstake<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::assert_pool_id<T0>(arg0, arg1);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::accrue_points(arg0, arg3);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::accrue_points<T0>(arg0, arg1, arg3);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::unstake(arg0, arg2);
        let v0 = SpoolAccountUnstakeEvent{
            spool_account_id : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg1),
            spool_id         : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            unstake_amount   : arg2,
            remaining_amount : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<T0>(arg1),
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v0);
        0x2::coin::from_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::unstake<T0>(arg1, arg2), arg4)
    }

    public fun new_spool_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::accrue_points(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::stake_type(arg0), 17);
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::new<T0>(arg0, arg2);
        let v1 = CreateSpoolAccountEvent{
            spool_account_id : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(&v0),
            spool_id         : 0x2::object::id<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            created_at       : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<CreateSpoolAccountEvent>(v1);
        v0
    }

    public entry fun update_points<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::accrue_points(arg0, arg2);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::accrue_points<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

