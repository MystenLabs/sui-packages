module 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::user {
    struct CreateSpoolAccountEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_account_key_id: 0x2::object::ID,
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        created_at: u64,
    }

    struct SpoolAccountUnstakeEvent has copy, drop {
        spool_account_id: 0x2::object::ID,
        spool_account_key_id: 0x2::object::ID,
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
        timestamp: u64,
    }

    public fun redeem_rewards<T0, T1>(arg0: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool, arg1: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::rewards_pool::RewardsPool<T1>, arg2: &0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccountKey, arg3: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::assert_pool_id<T0>(arg0, arg3);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::rewards_pool::assert_spool_id<T1>(arg1, arg0);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::assert_key<T0>(arg2, arg3);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::accrue_points(arg0, arg4);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::accrue_points<T0>(arg0, arg3, arg4);
        let v0 = 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::points<T0>(arg3);
        let v1 = 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::rewards_pool::redeem_rewards<T0, T1>(arg1, arg3);
        let v2 = SpoolAccountRedeemRewardsEvent{
            sender           : 0x2::tx_context::sender(arg5),
            spool_account_id : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>>(arg3),
            spool_id         : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool>(arg0),
            rewards_pool_id  : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::rewards_pool::RewardsPool<T1>>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            rewards_type     : 0x1::type_name::get<T1>(),
            redeemed_points  : v0 - 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::points<T0>(arg3),
            previous_points  : v0,
            rewards          : 0x2::balance::value<T1>(&v1),
            timestamp        : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEvent>(v2);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public entry fun stake<T0>(arg0: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool, arg1: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::assert_pool_id<T0>(arg0, arg1);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::accrue_points(arg0, arg3);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::accrue_points<T0>(arg0, arg1, arg3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::stakes(arg0) + v0 <= 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::max_stakes(arg0), 16);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::stake(arg0, v0);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::stake<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
        let v1 = SpoolAccountStakeEvent{
            sender           : 0x2::tx_context::sender(arg4),
            spool_account_id : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>>(arg1),
            spool_id         : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            stake_amount     : v0,
            previous_amount  : 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::stake_amount<T0>(arg1) - v0,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v1);
    }

    public fun unstake<T0>(arg0: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool, arg1: &0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccountKey, arg2: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::assert_pool_id<T0>(arg0, arg2);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::assert_key<T0>(arg1, arg2);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::accrue_points(arg0, arg4);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::accrue_points<T0>(arg0, arg2, arg4);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::unstake(arg0, arg3);
        let v0 = SpoolAccountUnstakeEvent{
            spool_account_id     : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>>(arg2),
            spool_account_key_id : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccountKey>(arg1),
            spool_id             : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool>(arg0),
            staking_type         : 0x1::type_name::get<T0>(),
            unstake_amount       : arg3,
            remaining_amount     : 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::stake_amount<T0>(arg2),
            timestamp            : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v0);
        0x2::coin::from_balance<T0>(0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::unstake<T0>(arg2, arg3), arg5)
    }

    public fun new_spool_account<T0>(arg0: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccountKey, 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>) {
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::accrue_points(arg0, arg1);
        let (v0, v1) = 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = CreateSpoolAccountEvent{
            spool_account_id     : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>>(&v2),
            spool_account_key_id : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccountKey>(&v3),
            spool_id             : 0x2::object::id<0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool>(arg0),
            staking_type         : 0x1::type_name::get<T0>(),
            created_at           : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<CreateSpoolAccountEvent>(v4);
        (v3, v2)
    }

    public entry fun update_points<T0>(arg0: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::Spool, arg1: &mut 0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool::accrue_points(arg0, arg2);
        0xa081f250cceca309db1f527ebe28da72c6227bc0ccc33302b873e05559818f4d::spool_account::accrue_points<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

