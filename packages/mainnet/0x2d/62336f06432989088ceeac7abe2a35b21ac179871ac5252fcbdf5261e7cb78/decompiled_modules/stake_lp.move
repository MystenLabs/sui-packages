module 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::stake_lp {
    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        lp_coin: 0x2::coin::Coin<T2>,
        esluck_reward_coin: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>,
        ext_reward_coin: 0x2::coin::Coin<T1>,
        reward_per_sec: u64,
        ext_reward_per_sec: u64,
        accum_reward: u64,
        ext_accum_reward: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        last_updated: u64,
        scale: u64,
        stakes: 0x2::bag::Bag,
        emergency_locked: bool,
        total_stakers: u256,
        total_rewards: u256,
        version: u64,
    }

    struct UserStake has drop, store {
        amount: u64,
        unobtainable_reward: u64,
        earned_reward: u64,
        earned_per_token_store: u64,
        ext_earned_reward: u64,
        ext_unobtainable_reward: u64,
        ext_earned_per_token_store: u64,
    }

    fun accum_rewards_since_last_updated<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : (u64, u64) {
        let v0 = (arg1 - arg0.last_updated) / 1000;
        let v1 = 0x2::coin::value<T2>(&arg0.lp_coin);
        if (v1 == 0) {
            (0, 0)
        } else {
            ((((v0 as u256) * (arg0.reward_per_sec as u256) * (arg0.scale as u256) / (v1 as u256)) as u64), (((v0 as u256) * (arg0.ext_reward_per_sec as u256) * (arg0.scale as u256) / (v1 as u256)) as u64))
        }
    }

    public entry fun add_reward_coin<T0, T1, T2>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2>, arg2: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        assert!(arg1.version == 1, 2001);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T0>(&mut arg1.esluck_reward_coin, arg2);
    }

    public entry fun change_ext_reward_per_sec<T0, T1, T2>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        arg1.ext_reward_per_sec = arg2;
    }

    public entry fun change_reward_per_sec<T0, T1, T2>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg4), 1005);
        assert!(arg1.version == 1, 2001);
        arg1.scale = arg3;
        arg1.reward_per_sec = arg2;
    }

    public entry fun claim<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2001);
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2>(arg0, arg1);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, arg0.scale, v2);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2>(arg0, v3, arg2);
        0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
    }

    public entry fun create_stake_pool<T0, T1, T2>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg8), 1005);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg6 > v0, 1002);
        let v1 = Pool<T0, T1, T2>{
            id                 : 0x2::object::new(arg8),
            lp_coin            : 0x2::coin::zero<T2>(arg8),
            esluck_reward_coin : arg1,
            ext_reward_coin    : arg2,
            reward_per_sec     : arg3,
            ext_reward_per_sec : arg4,
            accum_reward       : 0,
            ext_accum_reward   : 0,
            start_timestamp    : v0,
            end_timestamp      : arg6,
            last_updated       : v0,
            scale              : arg5,
            stakes             : 0x2::bag::new(arg8),
            emergency_locked   : false,
            total_stakers      : 0,
            total_rewards      : 0,
            version            : 1,
        };
        0x2::transfer::public_share_object<Pool<T0, T1, T2>>(v1);
    }

    public entry fun enable_emergency<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        assert!(arg0.version == 1, 2001);
        arg0.emergency_locked = true;
    }

    fun ext_user_earned_since_last_update(arg0: u64, arg1: u64, arg2: &UserStake) : u64 {
        (((arg2.amount as u256) * ((arg0 - arg2.ext_earned_per_token_store) as u256) / (arg1 as u256)) as u64)
    }

    fun get_time_for_last_update<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.end_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            arg0.end_timestamp
        } else {
            0x2::clock::timestamp_ms(arg1)
        }
    }

    public fun get_user_total_stake<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::bag::borrow<address, UserStake>(&arg0.stakes, 0x2::tx_context::sender(arg1)).amount
    }

    fun inner_claim<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut UserStake, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1.earned_reward;
        arg0.total_rewards = arg0.total_rewards + (v1 as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.esluck_reward_coin, 0x2::tx_context::sender(arg2), v1, arg2), v0);
        let v2 = 123;
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<u64>(&arg1.ext_earned_reward);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.ext_reward_coin, arg1.ext_earned_reward, arg2), v0);
        arg1.earned_reward = 0;
        arg1.ext_earned_reward = 0;
    }

    fun safe_remove_user_stake<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: UserStake) {
        assert!(arg1.amount == 0, 1006);
        assert!(arg1.earned_reward == 0, 1006);
        assert!(arg1.ext_earned_reward == 0, 1006);
        arg0.total_stakers = arg0.total_stakers - 1;
    }

    public entry fun stake<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T2>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2001);
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::coin::zero<T2>(arg4);
        0x2::pay::join_vec<T2>(&mut v0, arg1);
        assert!(0x2::coin::value<T2>(&v0) >= arg2, 1001);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::split<T2>(&mut v0, arg2, arg4);
        0x967b27a9015514855cbc4da46657a93b029bbed373fb45d9c214863e4efc6b17::utils::destroy_zero_or_transfer<T2>(v0, arg4);
        update_accum_reward<T0, T1, T2>(arg0, arg3);
        if (0x2::bag::contains<address>(&arg0.stakes, v1)) {
            let v3 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v1);
            let v4 = &mut v3;
            update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, arg0.scale, v4);
            let v5 = &mut v3;
            inner_claim<T0, T1, T2>(arg0, v5, arg4);
            v3.amount = v3.amount + arg2;
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v1, v3);
            0x2::coin::join<T2>(&mut arg0.lp_coin, v2);
        } else {
            0x2::coin::join<T2>(&mut arg0.lp_coin, v2);
            let v6 = UserStake{
                amount                     : arg2,
                unobtainable_reward        : 0,
                earned_reward              : 0,
                earned_per_token_store     : arg0.accum_reward,
                ext_earned_reward          : 0,
                ext_unobtainable_reward    : 0,
                ext_earned_per_token_store : arg0.ext_accum_reward,
            };
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v1, v6);
            arg0.total_stakers = arg0.total_stakers + 1;
        };
    }

    public entry fun unstake<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2001);
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2>(arg0, arg2);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, arg0.scale, v2);
        assert!(v1.amount >= arg1, 1006);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2>(arg0, v3, arg3);
        v1.amount = v1.amount - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg0.lp_coin, arg1, arg3), v0);
        if (v1.amount == 0) {
            safe_remove_user_stake<T0, T1, T2>(arg0, v1);
        } else {
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
        };
    }

    fun update_accum_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = get_time_for_last_update<T0, T1, T2>(arg0, arg1);
        let (v1, v2) = accum_rewards_since_last_updated<T0, T1, T2>(arg0, v0);
        arg0.last_updated = v0;
        if (v1 != 0) {
            arg0.accum_reward = arg0.accum_reward + v1;
        };
        if (v2 != 0) {
            arg0.ext_accum_reward = arg0.ext_accum_reward + v2;
        };
    }

    fun update_user_earnings(arg0: u64, arg1: u64, arg2: u64, arg3: &mut UserStake) {
        let v0 = user_earned_since_last_update(arg0, arg2, arg3);
        arg3.earned_reward = arg3.earned_reward + v0;
        arg3.unobtainable_reward = arg3.unobtainable_reward + v0;
        arg3.earned_per_token_store = arg0;
        let v1 = ext_user_earned_since_last_update(arg1, arg2, arg3);
        arg3.ext_earned_reward = arg3.ext_earned_reward + v1;
        arg3.ext_unobtainable_reward = arg3.ext_unobtainable_reward + v1;
        arg3.ext_earned_per_token_store = arg1;
    }

    fun user_earned_since_last_update(arg0: u64, arg1: u64, arg2: &UserStake) : u64 {
        (((arg2.amount as u256) * ((arg0 - arg2.earned_per_token_store) as u256) / (arg1 as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

