module 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::user {
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
        timestamp: u64,
    }

    public fun redeem_rewards<T0, T1>(arg0: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool, arg1: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::rewards_pool::RewardsPool<T1>, arg2: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::assert_pool_id<T0>(arg0, arg2);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::rewards_pool::assert_spool_id<T1>(arg1, arg0);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::accrue_points(arg0, arg3);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::accrue_points<T0>(arg0, arg2, arg3);
        let v0 = 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::points<T0>(arg2);
        let v1 = 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::rewards_pool::redeem_rewards<T0, T1>(arg1, arg2);
        let v2 = SpoolAccountRedeemRewardsEvent{
            sender           : 0x2::tx_context::sender(arg4),
            spool_account_id : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>>(arg2),
            spool_id         : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool>(arg0),
            rewards_pool_id  : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::rewards_pool::RewardsPool<T1>>(arg1),
            staking_type     : 0x1::type_name::get<T0>(),
            rewards_type     : 0x1::type_name::get<T1>(),
            redeemed_points  : v0 - 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::points<T0>(arg2),
            previous_points  : v0,
            rewards          : 0x2::balance::value<T1>(&v1),
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountRedeemRewardsEvent>(v2);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public entry fun stake<T0>(arg0: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool, arg1: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::assert_pool_id<T0>(arg0, arg1);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::accrue_points(arg0, arg3);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::accrue_points<T0>(arg0, arg1, arg3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::stakes(arg0) + v0 <= 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::max_stakes(arg0), 16);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::stake(arg0, v0);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::stake<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
        let v1 = SpoolAccountStakeEvent{
            sender           : 0x2::tx_context::sender(arg4),
            spool_account_id : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>>(arg1),
            spool_id         : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            stake_amount     : v0,
            previous_amount  : 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::stake_amount<T0>(arg1) - v0,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountStakeEvent>(v1);
    }

    public fun unstake<T0>(arg0: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool, arg1: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::assert_pool_id<T0>(arg0, arg1);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::accrue_points(arg0, arg3);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::accrue_points<T0>(arg0, arg1, arg3);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::unstake(arg0, arg2);
        let v0 = SpoolAccountUnstakeEvent{
            spool_account_id : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>>(arg1),
            spool_id         : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            unstake_amount   : arg2,
            remaining_amount : 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::stake_amount<T0>(arg1),
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<SpoolAccountUnstakeEvent>(v0);
        0x2::coin::from_balance<T0>(0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::unstake<T0>(arg1, arg2), arg4)
    }

    public fun new_spool_account<T0>(arg0: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0> {
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::accrue_points(arg0, arg1);
        assert!(0x1::type_name::get<T0>() == 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::stake_type(arg0), 17);
        let v0 = 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::new<T0>(arg0, arg2);
        let v1 = CreateSpoolAccountEvent{
            spool_account_id : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>>(&v0),
            spool_id         : 0x2::object::id<0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool>(arg0),
            staking_type     : 0x1::type_name::get<T0>(),
            created_at       : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<CreateSpoolAccountEvent>(v1);
        v0
    }

    public entry fun update_points<T0>(arg0: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::Spool, arg1: &mut 0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool::accrue_points(arg0, arg2);
        0xf392d97c1af2189a14ffd4d60a5709ba71bb8e73225d4e5c3bf93f7af432a4dc::spool_account::accrue_points<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

