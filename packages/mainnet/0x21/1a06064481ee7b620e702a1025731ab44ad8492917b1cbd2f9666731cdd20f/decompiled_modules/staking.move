module 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::staking {
    struct Pool<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4> has store, key {
        id: 0x2::object::UID,
        luck_coin: 0x2::coin::Coin<T2>,
        xluck_coin: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T3>,
        esluck_coin: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>,
        esluck_reward_coin: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>,
        ext_reward_coin: 0x2::coin::Coin<T1>,
        reward_per_sec: u64,
        ext_reward_per_sec: u64,
        accum_reward: u256,
        ext_accum_reward: u256,
        start_timestamp: u64,
        end_timestamp: u64,
        last_updated: u64,
        scale: u64,
        stakes: 0x2::bag::Bag,
        emergency_locked: bool,
        total_staked: u256,
        total_stakers: u256,
        total_rewards: u256,
        vest: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>,
        vest_duration: u64,
        vester: 0x2::bag::Bag,
        total_vest_amount: u256,
        total_vester: u256,
        total_vester_reward: u256,
    }

    struct UserVest has store {
        amount: u64,
        unobtainable_reward: u64,
        earned_reward: u64,
        lastet_updated: u64,
        passed_time: u64,
    }

    struct UserStake has drop, store {
        luck_amount: u64,
        xluck_amount: u64,
        esluck_amount: u64,
        unobtainable_reward: u64,
        earned_reward: u64,
        ext_earned_reward: u64,
        ext_unobtainable_reward: u64,
        earned_per_token_store: u64,
        ext_earned_per_token_store: u64,
    }

    fun accum_rewards_since_last_updated<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: u64) : (u256, u256) {
        let v0 = (arg1 - arg0.last_updated) / 1000;
        let v1 = total_staked<T0, T1, T2, T3, T4>(arg0);
        if (v1 == 0) {
            (0, 0)
        } else {
            let v4 = 90999999999;
            0x1::debug::print<u64>(&v4);
            0x1::debug::print<u64>(&v0);
            0x1::debug::print<u64>(&arg0.reward_per_sec);
            0x1::debug::print<u64>(&arg0.scale);
            0x1::debug::print<u256>(&v1);
            let v5 = (v0 as u256) * (arg0.reward_per_sec as u256) * (arg0.scale as u256) / v1;
            let v6 = (v0 as u256) * (arg0.ext_reward_per_sec as u256) * (arg0.scale as u256) / v1;
            0x1::debug::print<u256>(&v5);
            0x1::debug::print<u256>(&v6);
            (v5, v6)
        }
    }

    public entry fun add_ext_reward_coin<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2, T3, T4>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        0x2::coin::join<T1>(&mut arg1.ext_reward_coin, arg2);
    }

    public entry fun add_reward_coin<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2, T3, T4>, arg2: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T0>(&mut arg1.esluck_reward_coin, arg2);
    }

    public fun calculate_staker_can_unstake(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg4 <= arg3, 1008);
        assert!((arg0 as u256) * (1000000000 as u256) >= (arg2 as u256), 1008);
        let v0 = (((arg0 as u256) * (1000000000 as u256) / (arg2 as u256)) as u64);
        assert!(v0 <= arg3, 1008);
        let v1 = arg3 - v0;
        let v2 = 11111;
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<u64>(&arg3);
        0x1::debug::print<u64>(&arg4);
        0x1::debug::print<u64>(&v1);
        assert!(v1 >= arg4, 1008);
    }

    public fun calculate_staker_need_stake(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg1 == 0) {
            return
        };
        assert!((arg0 as u256) * (1000000000 as u256) >= (arg2 as u256), 1010);
        let v0 = (((arg0 as u256) * (1000000000 as u256) / (arg2 as u256)) as u64);
        0x1::debug::print<u64>(&v0);
        assert!(arg3 >= v0, 1010);
    }

    public entry fun change_ext_reward_per_sec<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2, T3, T4>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        arg1.ext_reward_per_sec = arg2;
    }

    public entry fun change_reward_per_sec<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2, T3, T4>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg4), 1005);
        arg1.scale = arg3;
        arg1.reward_per_sec = arg2;
    }

    public entry fun change_vest_duration<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Pool<T0, T1, T2, T3, T4>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg3), 1005);
        arg1.vest_duration = arg2;
    }

    fun check_amount<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &UserStake, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_user_vesting<T0, T1, T2, T3, T4>(arg0, arg3);
        calculate_staker_can_unstake(v0, v1, (arg0.accum_reward as u64), user_total_stake(arg1.luck_amount, arg1.xluck_amount, arg1.esluck_amount), arg2);
    }

    fun check_deposit_amount<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &UserStake, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = get_user_vesting<T0, T1, T2, T3, T4>(arg0, arg2);
        calculate_staker_need_stake(v0, v1, (arg0.accum_reward as u64), user_total_stake(arg1.luck_amount, arg1.xluck_amount, arg1.esluck_amount));
    }

    public entry fun claim<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg1);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v2);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2, T3, T4>(arg0, v3, arg2);
        if (user_total_stake(v1.luck_amount, v1.xluck_amount, v1.esluck_amount) == 0) {
            safe_remove_user_stake<T0, T1, T2, T3, T4>(arg0, v1);
        } else {
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
        };
    }

    public entry fun claim_vest<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vester, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vester, v0);
        let v2 = &mut v1;
        update_user_vest_earnings(arg0.vest_duration, v2, arg2);
        let v3 = &mut v1;
        inner_vest_claim(arg1, v3, arg3);
        0x1::debug::print<UserVest>(&v1);
        if (v1.amount - v1.unobtainable_reward > 0) {
            0x2::bag::add<address, UserVest>(&mut arg0.vester, v0, v1);
        } else {
            arg0.total_vester = arg0.total_vester - 1;
            let UserVest {
                amount              : v4,
                unobtainable_reward : v5,
                earned_reward       : _,
                lastet_updated      : _,
                passed_time         : _,
            } = v1;
            assert!(v4 == v5, 1008);
        };
    }

    public entry fun claim_vest_luck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vester, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vester, v0);
        let v2 = &mut v1;
        update_user_vest_earnings(arg0.vest_duration, v2, arg2);
        let v3 = &mut v1;
        new_inner_vest_claim(arg1, v3, arg3);
        0x1::debug::print<UserVest>(&v1);
        if (v1.amount - v1.unobtainable_reward > 0) {
            0x2::bag::add<address, UserVest>(&mut arg0.vester, v0, v1);
        } else {
            arg0.total_vester = arg0.total_vester - 1;
            let UserVest {
                amount              : v4,
                unobtainable_reward : v5,
                earned_reward       : _,
                lastet_updated      : _,
                passed_time         : _,
            } = v1;
            assert!(v4 == v5, 1008);
        };
    }

    public entry fun create_stake_pool<T0, T1, T2, T3, T4>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg9), 1005);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg7 > v0, 1002);
        let v1 = Pool<T0, T1, T2, T3, T4>{
            id                  : 0x2::object::new(arg9),
            luck_coin           : 0x2::coin::zero<T2>(arg9),
            xluck_coin          : 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T3>(0x2::tx_context::sender(arg9), arg9),
            esluck_coin         : 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T4>(0x2::tx_context::sender(arg9), arg9),
            esluck_reward_coin  : arg1,
            ext_reward_coin     : arg2,
            reward_per_sec      : arg3,
            ext_reward_per_sec  : arg4,
            accum_reward        : 0,
            ext_accum_reward    : 0,
            start_timestamp     : v0,
            end_timestamp       : arg7,
            last_updated        : v0,
            scale               : arg5,
            stakes              : 0x2::bag::new(arg9),
            emergency_locked    : false,
            total_staked        : 0,
            total_stakers       : 0,
            total_rewards       : 0,
            vest                : 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T4>(0x2::tx_context::sender(arg9), arg9),
            vest_duration       : arg6,
            vester              : 0x2::bag::new(arg9),
            total_vest_amount   : 0,
            total_vester        : 0,
            total_vester_reward : 0,
        };
        0x2::transfer::public_share_object<Pool<T0, T1, T2, T3, T4>>(v1);
    }

    public entry fun deposit<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1009);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T4>(v0, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T4>(&mut v1, arg2);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T4>(&v1) >= arg3, 1001);
        let v2 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut v1, v0, arg3, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T4>(v1, arg5);
        if (0x2::bag::contains<address>(&arg0.vester, v0)) {
            let v3 = 0x2::bag::borrow_mut<address, UserVest>(&mut arg0.vester, v0);
            update_user_vest_earnings(arg0.vest_duration, v3, arg4);
            inner_vest_claim(arg1, v3, arg5);
            v3.amount = v3.amount + arg3;
            v3.unobtainable_reward = 0;
            v3.lastet_updated = 0x2::clock::timestamp_ms(arg4);
            v3.passed_time = 0;
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.vest, v2);
        } else {
            let v4 = UserVest{
                amount              : arg3,
                unobtainable_reward : 0,
                earned_reward       : 0,
                lastet_updated      : 0x2::clock::timestamp_ms(arg4),
                passed_time         : 0,
            };
            0x2::bag::add<address, UserVest>(&mut arg0.vester, v0, v4);
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.vest, v2);
            arg0.total_vester = arg0.total_vester + 1;
        };
        check_deposit_amount<T0, T1, T2, T3, T4>(arg0, 0x2::bag::borrow<address, UserStake>(&mut arg0.stakes, v0), arg5);
    }

    public entry fun deposit_to<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1009);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T4>(v0, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T4>(&mut v1, arg2);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T4>(&v1) >= arg3, 1001);
        let v2 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut v1, v0, arg3, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T4>(v1, arg5);
        if (0x2::bag::contains<address>(&arg0.vester, v0)) {
            let v3 = 0x2::bag::borrow_mut<address, UserVest>(&mut arg0.vester, v0);
            update_user_vest_earnings(arg0.vest_duration, v3, arg4);
            new_inner_vest_claim(arg1, v3, arg5);
            v3.amount = v3.amount + arg3;
            v3.unobtainable_reward = 0;
            v3.lastet_updated = 0x2::clock::timestamp_ms(arg4);
            v3.passed_time = 0;
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.vest, v2);
        } else {
            let v4 = UserVest{
                amount              : arg3,
                unobtainable_reward : 0,
                earned_reward       : 0,
                lastet_updated      : 0x2::clock::timestamp_ms(arg4),
                passed_time         : 0,
            };
            0x2::bag::add<address, UserVest>(&mut arg0.vester, v0, v4);
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.vest, v2);
            arg0.total_vester = arg0.total_vester + 1;
        };
        check_deposit_amount<T0, T1, T2, T3, T4>(arg0, 0x2::bag::borrow<address, UserStake>(&mut arg0.stakes, v0), arg5);
    }

    public entry fun enable_emergency<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        arg0.emergency_locked = true;
    }

    fun ext_user_earned_since_last_update(arg0: u256, arg1: u256, arg2: &UserStake) : u256 {
        (user_total_stake(arg2.luck_amount, arg2.xluck_amount, arg2.esluck_amount) as u256) * (arg0 - (arg2.ext_earned_per_token_store as u256)) / arg1
    }

    public fun get_reward_per_sec<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>) : u64 {
        arg0.reward_per_sec
    }

    fun get_time_for_last_update<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.end_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            arg0.end_timestamp
        } else {
            0x2::clock::timestamp_ms(arg1)
        }
    }

    public fun get_user_total_stake<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::bag::borrow<address, UserStake>(&arg0.stakes, 0x2::tx_context::sender(arg1));
        user_total_stake(v0.luck_amount, v0.xluck_amount, v0.esluck_amount)
    }

    public fun get_user_total_stake_amount<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::bag::borrow<address, UserStake>(&arg0.stakes, 0x2::tx_context::sender(arg1));
        user_total_stake(v0.luck_amount, v0.xluck_amount, v0.esluck_amount)
    }

    public fun get_user_vestin<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::bag::contains<address>(&arg0.vester, v0)) {
            let v3 = 0x2::bag::borrow<address, UserVest>(&arg0.vester, v0);
            (v3.amount, arg0.vest_duration - v3.passed_time)
        } else {
            (0, 0)
        }
    }

    fun get_user_vesting<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::bag::contains<address>(&arg0.vester, v0)) {
            let v3 = 0x2::bag::borrow<address, UserVest>(&arg0.vester, v0);
            let v4 = 2222222222222;
            0x1::debug::print<u64>(&v4);
            0x1::debug::print<u64>(&v3.amount);
            0x1::debug::print<UserVest>(v3);
            (v3.amount, arg0.vest_duration - v3.passed_time)
        } else {
            (0, 0)
        }
    }

    fun inner_claim<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut UserStake, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1.earned_reward;
        arg0.total_rewards = arg0.total_rewards + (v1 as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.esluck_reward_coin, 0x2::tx_context::sender(arg2), v1, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.ext_reward_coin, arg1.ext_earned_reward, arg2), v0);
        arg1.earned_reward = 0;
        arg1.ext_earned_reward = 0;
    }

    fun inner_vest_claim(arg0: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg1: &mut UserVest, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::get_luck(arg0, arg1.earned_reward, arg2), 0x2::tx_context::sender(arg2));
        arg1.earned_reward = 0;
    }

    fun new_inner_vest_claim(arg0: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg1: &mut UserVest, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::new_get_luck(arg0, arg1.earned_reward, arg2), 0x2::tx_context::sender(arg2));
        arg1.earned_reward = 0;
    }

    fun safe_remove_user_stake<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: UserStake) {
        assert!(arg1.xluck_amount == 0, 1006);
        assert!(arg1.esluck_amount == 0, 1006);
        assert!(arg1.luck_amount == 0, 1006);
        assert!(arg1.earned_reward == 0, 1006);
        assert!(arg1.ext_earned_reward == 0, 1006);
        arg0.total_stakers = arg0.total_stakers - 1;
    }

    public entry fun stake_esluck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T4>(v0, arg4);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T4>(&mut v1, arg1);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T4>(&v1) >= arg2, 1001);
        let v2 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut v1, v0, arg2, arg4);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T4>(v1, arg4);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg3);
        arg0.total_staked = arg0.total_staked + (arg2 as u256);
        if (0x2::bag::contains<address>(&arg0.stakes, v0)) {
            let v3 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
            let v4 = &mut v3;
            update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v4);
            let v5 = &mut v3;
            inner_claim<T0, T1, T2, T3, T4>(arg0, v5, arg4);
            v3.esluck_amount = v3.esluck_amount + arg2;
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v3);
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.esluck_coin, v2);
        } else {
            let v6 = UserStake{
                luck_amount                : 0,
                xluck_amount               : 0,
                esluck_amount              : arg2,
                unobtainable_reward        : 0,
                earned_reward              : 0,
                ext_earned_reward          : 0,
                ext_unobtainable_reward    : 0,
                earned_per_token_store     : (arg0.accum_reward as u64),
                ext_earned_per_token_store : (arg0.ext_accum_reward as u64),
            };
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v6);
            arg0.total_stakers = arg0.total_stakers + 1;
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T4>(&mut arg0.esluck_coin, v2);
        };
    }

    public entry fun stake_luck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: vector<0x2::coin::Coin<T2>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::coin::zero<T2>(arg4);
        0x2::pay::join_vec<T2>(&mut v0, arg1);
        assert!(0x2::coin::value<T2>(&v0) >= arg2, 1001);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::split<T2>(&mut v0, arg2, arg4);
        0x967b27a9015514855cbc4da46657a93b029bbed373fb45d9c214863e4efc6b17::utils::destroy_zero_or_transfer<T2>(v0, arg4);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg3);
        arg0.total_staked = arg0.total_staked + (arg2 as u256);
        if (0x2::bag::contains<address>(&arg0.stakes, v1)) {
            let v3 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v1);
            let v4 = &mut v3;
            update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v4);
            let v5 = &mut v3;
            inner_claim<T0, T1, T2, T3, T4>(arg0, v5, arg4);
            v3.luck_amount = v3.luck_amount + arg2;
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v1, v3);
            0x2::coin::join<T2>(&mut arg0.luck_coin, v2);
        } else {
            let v6 = UserStake{
                luck_amount                : arg2,
                xluck_amount               : 0,
                esluck_amount              : 0,
                unobtainable_reward        : 0,
                earned_reward              : 0,
                ext_earned_reward          : 0,
                ext_unobtainable_reward    : 0,
                earned_per_token_store     : (arg0.accum_reward as u64),
                ext_earned_per_token_store : (arg0.ext_accum_reward as u64),
            };
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v1, v6);
            arg0.total_stakers = arg0.total_stakers + 1;
            0x2::coin::join<T2>(&mut arg0.luck_coin, v2);
        };
    }

    public entry fun stake_xluck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T3>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T3>(v0, arg4);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T3>(&mut v1, arg1);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T3>(&v1) >= arg2, 1001);
        let v2 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T3>(&mut v1, v0, arg2, arg4);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T3>(v1, arg4);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg3);
        arg0.total_staked = arg0.total_staked + (arg2 as u256);
        if (0x2::bag::contains<address>(&arg0.stakes, v0)) {
            let v3 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
            let v4 = &mut v3;
            update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v4);
            let v5 = &mut v3;
            inner_claim<T0, T1, T2, T3, T4>(arg0, v5, arg4);
            v3.xluck_amount = v3.xluck_amount + arg2;
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v3);
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T3>(&mut arg0.xluck_coin, v2);
        } else {
            let v6 = UserStake{
                luck_amount                : 0,
                xluck_amount               : arg2,
                esluck_amount              : 0,
                unobtainable_reward        : 0,
                earned_reward              : 0,
                ext_earned_reward          : 0,
                ext_unobtainable_reward    : 0,
                earned_per_token_store     : (arg0.accum_reward as u64),
                ext_earned_per_token_store : (arg0.ext_accum_reward as u64),
            };
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v6);
            arg0.total_stakers = arg0.total_stakers + 1;
            0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T3>(&mut arg0.xluck_coin, v2);
        };
    }

    public fun total_staked<T0, T1, T2, T3, T4>(arg0: &Pool<T0, T1, T2, T3, T4>) : u256 {
        (0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T4>(&arg0.esluck_coin) as u256) + (0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T3>(&arg0.xluck_coin) as u256) + (0x2::coin::value<T2>(&arg0.luck_coin) as u256)
    }

    public entry fun unstake_esluck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg2);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v2);
        check_amount<T0, T1, T2, T3, T4>(arg0, &v1, arg1, arg3);
        assert!(v1.esluck_amount >= arg1, 1007);
        v1.esluck_amount = v1.esluck_amount - arg1;
        arg0.total_staked = arg0.total_staked - (arg1 as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut arg0.esluck_coin, v0, arg1, arg3), v0);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2, T3, T4>(arg0, v3, arg3);
        if (user_total_stake(v1.luck_amount, v1.xluck_amount, v1.esluck_amount) == 0) {
            safe_remove_user_stake<T0, T1, T2, T3, T4>(arg0, v1);
        } else {
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
        };
    }

    public entry fun unstake_luck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg2);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v2);
        check_amount<T0, T1, T2, T3, T4>(arg0, &v1, arg1, arg3);
        assert!(v1.luck_amount >= arg1, 1007);
        v1.luck_amount = v1.luck_amount - arg1;
        arg0.total_staked = arg0.total_staked - (arg1 as u256);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut arg0.luck_coin, arg1, arg3), v0);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2, T3, T4>(arg0, v3, arg3);
        if (user_total_stake(v1.luck_amount, v1.xluck_amount, v1.esluck_amount) == 0) {
            safe_remove_user_stake<T0, T1, T2, T3, T4>(arg0, v1);
        } else {
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
        };
    }

    public entry fun unstake_xluck<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.stakes, v0), 1003);
        update_accum_reward<T0, T1, T2, T3, T4>(arg0, arg2);
        let v1 = 0x2::bag::remove<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.accum_reward, arg0.ext_accum_reward, (arg0.scale as u256), v2);
        check_amount<T0, T1, T2, T3, T4>(arg0, &v1, arg1, arg3);
        assert!(v1.xluck_amount >= arg1, 1007);
        v1.xluck_amount = v1.xluck_amount - arg1;
        arg0.total_staked = arg0.total_staked - (arg1 as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T3>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T3>(&mut arg0.xluck_coin, v0, arg1, arg3), v0);
        let v3 = &mut v1;
        inner_claim<T0, T1, T2, T3, T4>(arg0, v3, arg3);
        if (user_total_stake(v1.luck_amount, v1.xluck_amount, v1.esluck_amount) == 0) {
            safe_remove_user_stake<T0, T1, T2, T3, T4>(arg0, v1);
        } else {
            0x2::bag::add<address, UserStake>(&mut arg0.stakes, v0, v1);
        };
    }

    fun update_accum_reward<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &0x2::clock::Clock) {
        let v0 = get_time_for_last_update<T0, T1, T2, T3, T4>(arg0, arg1);
        let (v1, v2) = accum_rewards_since_last_updated<T0, T1, T2, T3, T4>(arg0, v0);
        arg0.last_updated = v0;
        if (v1 != 0) {
            arg0.accum_reward = arg0.accum_reward + v1;
            arg0.ext_accum_reward = arg0.ext_accum_reward + v2;
        };
    }

    fun update_user_earnings(arg0: u256, arg1: u256, arg2: u256, arg3: &mut UserStake) {
        let v0 = user_earned_since_last_update(arg0, arg2, arg3);
        arg3.earned_reward = arg3.earned_reward + (v0 as u64);
        arg3.unobtainable_reward = arg3.unobtainable_reward + (v0 as u64);
        arg3.earned_per_token_store = (arg0 as u64);
        let v1 = ext_user_earned_since_last_update(arg1, arg2, arg3);
        arg3.ext_earned_reward = arg3.ext_earned_reward + (v1 as u64);
        arg3.ext_unobtainable_reward = arg3.ext_unobtainable_reward + (v1 as u64);
        arg3.ext_earned_per_token_store = (arg1 as u64);
    }

    fun update_user_vest_earnings(arg0: u64, arg1: &mut UserVest, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = ((((v0 - arg1.lastet_updated) as u256) * (arg1.amount as u256) / (arg0 as u256)) as u64);
        arg1.earned_reward = arg1.earned_reward + v1;
        if (arg1.unobtainable_reward + v1 > arg1.amount) {
            arg1.unobtainable_reward = arg1.amount;
        } else {
            arg1.unobtainable_reward = arg1.unobtainable_reward + v1;
        };
        arg1.passed_time = arg1.passed_time + v0 - arg1.lastet_updated;
        arg1.lastet_updated = v0;
    }

    fun user_earned_since_last_update(arg0: u256, arg1: u256, arg2: &UserStake) : u256 {
        (user_total_stake(arg2.luck_amount, arg2.xluck_amount, arg2.esluck_amount) as u256) * (arg0 - (arg2.earned_per_token_store as u256)) / arg1
    }

    fun user_total_stake(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 + arg2
    }

    public entry fun withdraw<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vester, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vester, v0);
        let v2 = &mut v1;
        update_user_vest_earnings(arg0.vest_duration, v2, arg2);
        let v3 = &mut v1;
        inner_vest_claim(arg1, v3, arg3);
        let UserVest {
            amount              : v4,
            unobtainable_reward : v5,
            earned_reward       : _,
            lastet_updated      : _,
            passed_time         : _,
        } = v1;
        arg0.total_vester = arg0.total_vester - 1;
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut arg0.vest, v0, v4 - v5, arg3), v0);
    }

    public entry fun withdraw_to<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T1, T2, T3, T4>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vester, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vester, v0);
        let v2 = &mut v1;
        update_user_vest_earnings(arg0.vest_duration, v2, arg2);
        let v3 = &mut v1;
        new_inner_vest_claim(arg1, v3, arg3);
        let UserVest {
            amount              : v4,
            unobtainable_reward : v5,
            earned_reward       : _,
            lastet_updated      : _,
            passed_time         : _,
        } = v1;
        arg0.total_vester = arg0.total_vester - 1;
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T4>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T4>(&mut arg0.vest, v0, v4 - v5, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

