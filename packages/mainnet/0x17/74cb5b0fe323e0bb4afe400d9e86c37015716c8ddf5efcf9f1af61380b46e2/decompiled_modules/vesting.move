module 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::vesting {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        stake_coins: 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>,
        vesting_duration: u64,
        vesters: 0x2::bag::Bag,
        emergency_locked: bool,
        total_vested: u256,
        total_vesters: u256,
        total_vester_rewards: u256,
    }

    struct UserVest has store {
        amount: u64,
        unobtainable_reward: u64,
        earned_reward: u64,
        lastet_updated: u64,
        passed_time: u64,
    }

    public entry fun claim<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vesters, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vesters, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.vesting_duration, v2, arg2);
        let v3 = &mut v1;
        inner_claim(arg1, v3, arg3);
        if (v1.amount != v1.unobtainable_reward) {
            0x2::bag::add<address, UserVest>(&mut arg0.vesters, v0, v1);
        } else {
            arg0.total_vesters = arg0.total_vesters - 1;
            let UserVest {
                amount              : v4,
                unobtainable_reward : v5,
                earned_reward       : _,
                lastet_updated      : _,
                passed_time         : _,
            } = v1;
            assert!(v4 == v5, 1002);
        };
    }

    public entry fun claim_luck<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vesters, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vesters, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.vesting_duration, v2, arg2);
        let v3 = &mut v1;
        new_inner_claim(arg1, v3, arg3);
        if (v1.amount != v1.unobtainable_reward) {
            0x2::bag::add<address, UserVest>(&mut arg0.vesters, v0, v1);
        } else {
            arg0.total_vesters = arg0.total_vesters - 1;
            let UserVest {
                amount              : v4,
                unobtainable_reward : v5,
                earned_reward       : _,
                lastet_updated      : _,
                passed_time         : _,
            } = v1;
            assert!(v4 == v5, 1002);
        };
    }

    public entry fun create_pool<T0>(arg0: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg0, arg2), 1005);
        let v0 = Pool<T0>{
            id                   : 0x2::object::new(arg2),
            stake_coins          : 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T0>(0x2::tx_context::sender(arg2), arg2),
            vesting_duration     : arg1,
            vesters              : 0x2::bag::new(arg2),
            emergency_locked     : false,
            total_vested         : 0,
            total_vesters        : 0,
            total_vester_rewards : 0,
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T0>(v0, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T0>(&mut v1, arg2);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T0>(&v1) >= arg3, 1001);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T0>(&mut arg0.stake_coins, 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut v1, v0, arg3, arg5));
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T0>(v1, arg5);
        if (0x2::bag::contains<address>(&arg0.vesters, v0)) {
            let v2 = 0x2::bag::borrow_mut<address, UserVest>(&mut arg0.vesters, v0);
            update_user_earnings(arg0.vesting_duration, v2, arg4);
            inner_claim(arg1, v2, arg5);
            v2.amount = v2.amount + arg3;
            v2.unobtainable_reward = 0;
            v2.lastet_updated = 0x2::clock::timestamp_ms(arg4);
            v2.passed_time = 0;
            arg0.total_vested = arg0.total_vested + (arg3 as u256);
        } else {
            let v3 = UserVest{
                amount              : arg3,
                unobtainable_reward : 0,
                earned_reward       : 0,
                lastet_updated      : 0x2::clock::timestamp_ms(arg4),
                passed_time         : 0,
            };
            0x2::bag::add<address, UserVest>(&mut arg0.vesters, v0, v3);
            arg0.total_vested = arg0.total_vested + (arg3 as u256);
            arg0.total_vesters = arg0.total_vesters + 1;
        };
    }

    public entry fun deposit_to<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: vector<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::zero<T0>(v0, arg5);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join_vec<T0>(&mut v1, arg2);
        assert!(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::value<T0>(&v1) >= arg3, 1001);
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::join<T0>(&mut arg0.stake_coins, 0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut v1, v0, arg3, arg5));
        0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::destroy_zero_or_transfer<T0>(v1, arg5);
        if (0x2::bag::contains<address>(&arg0.vesters, v0)) {
            let v2 = 0x2::bag::borrow_mut<address, UserVest>(&mut arg0.vesters, v0);
            update_user_earnings(arg0.vesting_duration, v2, arg4);
            new_inner_claim(arg1, v2, arg5);
            v2.amount = v2.amount + arg3;
            v2.unobtainable_reward = 0;
            v2.lastet_updated = 0x2::clock::timestamp_ms(arg4);
            v2.passed_time = 0;
            arg0.total_vested = arg0.total_vested + (arg3 as u256);
        } else {
            let v3 = UserVest{
                amount              : arg3,
                unobtainable_reward : 0,
                earned_reward       : 0,
                lastet_updated      : 0x2::clock::timestamp_ms(arg4),
                passed_time         : 0,
            };
            0x2::bag::add<address, UserVest>(&mut arg0.vesters, v0, v3);
            arg0.total_vested = arg0.total_vested + (arg3 as u256);
            arg0.total_vesters = arg0.total_vesters + 1;
        };
    }

    public entry fun enable_emergency<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        arg0.emergency_locked = true;
    }

    public entry fun get_user_vesting<T0>(arg0: &Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::bag::contains<address>(&arg0.vesters, v0)) {
            let v3 = 0x2::bag::borrow<address, UserVest>(&arg0.vesters, v0);
            (v3.amount, arg0.vesting_duration - v3.passed_time)
        } else {
            (0, 0)
        }
    }

    fun inner_claim(arg0: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg1: &mut UserVest, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::get_luck(arg0, arg1.earned_reward, arg2), 0x2::tx_context::sender(arg2));
        arg1.earned_reward = 0;
    }

    fun new_inner_claim(arg0: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg1: &mut UserVest, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::new_get_luck(arg0, arg1.earned_reward, arg2), 0x2::tx_context::sender(arg2));
        arg1.earned_reward = 0;
    }

    fun update_user_earnings(arg0: u64, arg1: &mut UserVest, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = ((((v0 - arg1.lastet_updated) as u256) * (arg1.amount as u256) / (arg0 as u256)) as u64);
        if (arg1.unobtainable_reward + v1 > arg1.amount) {
            arg1.earned_reward = arg1.amount;
            arg1.unobtainable_reward = arg1.amount;
        } else {
            arg1.earned_reward = arg1.earned_reward + v1;
            arg1.unobtainable_reward = arg1.unobtainable_reward + v1;
        };
        arg1.passed_time = arg1.passed_time + v0 - arg1.lastet_updated;
        arg1.lastet_updated = v0;
    }

    public entry fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::Vault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vesters, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vesters, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.vesting_duration, v2, arg2);
        let v3 = &mut v1;
        inner_claim(arg1, v3, arg3);
        let UserVest {
            amount              : v4,
            unobtainable_reward : v5,
            earned_reward       : _,
            lastet_updated      : _,
            passed_time         : _,
        } = v1;
        arg0.total_vesters = arg0.total_vesters - 1;
        arg0.total_vested = arg0.total_vested - ((v4 - v5) as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.stake_coins, v0, v4 - v5, arg3), v0);
    }

    public entry fun withdraw_to<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault::LuckVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_locked, 1004);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::bag::contains<address>(&arg0.vesters, v0), 1003);
        let v1 = 0x2::bag::remove<address, UserVest>(&mut arg0.vesters, v0);
        let v2 = &mut v1;
        update_user_earnings(arg0.vesting_duration, v2, arg2);
        let v3 = &mut v1;
        new_inner_claim(arg1, v3, arg3);
        let UserVest {
            amount              : v4,
            unobtainable_reward : v5,
            earned_reward       : _,
            lastet_updated      : _,
            passed_time         : _,
        } = v1;
        arg0.total_vesters = arg0.total_vesters - 1;
        arg0.total_vested = arg0.total_vested - ((v4 - v5) as u256);
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::split<T0>(&mut arg0.stake_coins, v0, v4 - v5, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

