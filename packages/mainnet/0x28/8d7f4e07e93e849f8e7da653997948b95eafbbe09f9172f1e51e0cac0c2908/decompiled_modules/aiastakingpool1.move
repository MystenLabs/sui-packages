module 0x288d7f4e07e93e849f8e7da653997948b95eafbbe09f9172f1e51e0cac0c2908::aiastakingpool1 {
    struct StakeInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        stake_amount: u64,
        stake_timestamp: u64,
        withdrawable_timestamp: u64,
        withdrawn: bool,
        early_stake_id: u64,
    }

    struct StakingPoolState<phantom T0> has key {
        id: 0x2::object::UID,
        staked_coins_treasury: 0x2::balance::Balance<T0>,
        rewards_treasury: 0x2::balance::Balance<T0>,
        user_reward_tokens: 0x2::table::Table<address, u64>,
        user_stake_records: 0x2::table::Table<address, vector<StakeInfo<T0>>>,
        lock_period: u64,
        is_staking_paused: bool,
        is_withdraw_paused: bool,
    }

    struct CreateStakeEvent has copy, drop {
        user: address,
        type_name: 0x1::string::String,
    }

    struct StakeEvent has copy, drop {
        stake_object_id: 0x2::object::ID,
        user: address,
        amount: u64,
        stake_timestamp: u64,
        withdrawable_timestamp: u64,
        early_stake_id: u64,
        referrer_code: 0x1::string::String,
        coin_type: 0x1::string::String,
    }

    struct AdminSetRewardEvent has copy, drop {
        user: address,
        ts: u64,
        reward_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        stake_object_id: 0x2::object::ID,
        user: address,
        withdraw_timestamp: u64,
        amount: u64,
        coin_type: 0x1::string::String,
    }

    struct WithdrawEventList has copy, drop {
        events: vector<WithdrawEvent>,
    }

    struct WithdrawRewardEvent has copy, drop {
        user: address,
        withdraw_timestamp: u64,
        reward_amount: u64,
        coin_type: 0x1::string::String,
    }

    struct StakeCancelEvent has copy, drop {
        stake_object_id: 0x2::object::ID,
        user: address,
        cancelled_amount: u64,
        cancel_timestamp: u64,
        admin: address,
        coin_type: 0x1::string::String,
    }

    struct AdminEvent has copy, drop {
        admin: address,
        action: 0x1::string::String,
    }

    struct DevAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_deposit_rewards<T0>(arg0: &mut StakingPoolState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.rewards_treasury, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg2),
            action : 0x1::string::utf8(b"admin_deposit_rewards"),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun admin_deposit_tokens<T0>(arg0: &mut StakingPoolState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.staked_coins_treasury, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg2),
            action : 0x1::string::utf8(b"admin_deposit_tokens"),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun admin_set_early_stake<T0>(arg0: &DevAdminCap, arg1: &mut StakingPoolState<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg4), 0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg5), 0);
        let v0 = now_seconds(arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg4, v1);
            assert!(v3 >= 1000000000, 1008);
            assert!(v4 > 0, 1013);
            let v5 = StakeInfo<T0>{
                id                     : 0x2::object::new(arg7),
                stake_amount           : v3,
                stake_timestamp        : v0,
                withdrawable_timestamp : *0x1::vector::borrow<u64>(&arg5, v1),
                withdrawn              : false,
                early_stake_id         : v4,
            };
            if (!0x2::table::contains<address, vector<StakeInfo<T0>>>(&arg1.user_stake_records, v2)) {
                0x2::table::add<address, vector<StakeInfo<T0>>>(&mut arg1.user_stake_records, v2, 0x1::vector::empty<StakeInfo<T0>>());
            };
            let v6 = StakeEvent{
                stake_object_id        : 0x2::object::uid_to_inner(&v5.id),
                user                   : v2,
                amount                 : v3,
                stake_timestamp        : v0,
                withdrawable_timestamp : v5.withdrawable_timestamp,
                early_stake_id         : v4,
                referrer_code          : 0x1::string::utf8(b""),
                coin_type              : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            };
            0x2::event::emit<StakeEvent>(v6);
            0x1::vector::push_back<StakeInfo<T0>>(0x2::table::borrow_mut<address, vector<StakeInfo<T0>>>(&mut arg1.user_stake_records, v2), v5);
            v1 = v1 + 1;
        };
        let v7 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg7),
            action : 0x1::string::utf8(b"admin_set_stake"),
        };
        0x2::event::emit<AdminEvent>(v7);
    }

    public fun admin_set_rewards<T0>(arg0: &DevAdminCap, arg1: &mut StakingPoolState<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            if (!0x2::table::contains<address, u64>(&arg1.user_reward_tokens, v1)) {
                0x2::table::add<address, u64>(&mut arg1.user_reward_tokens, v1, v2);
            } else {
                let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_reward_tokens, v1);
                *v3 = *v3 + v2;
            };
            let v4 = AdminSetRewardEvent{
                user          : v1,
                ts            : now_seconds(arg4),
                reward_amount : v2,
            };
            0x2::event::emit<AdminSetRewardEvent>(v4);
            v0 = v0 + 1;
        };
        let v5 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg5),
            action : 0x1::string::utf8(b"admin_set_rewards"),
        };
        0x2::event::emit<AdminEvent>(v5);
    }

    public fun admin_set_staking_status<T0>(arg0: &DevAdminCap, arg1: &mut StakingPoolState<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_staking_paused = arg2;
        let v0 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg3),
            action : 0x1::string::utf8(b"admin_set_staking_status"),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun admin_set_withdraw_status<T0>(arg0: &DevAdminCap, arg1: &mut StakingPoolState<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_withdraw_paused = arg2;
        let v0 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg3),
            action : 0x1::string::utf8(b"admin_set_withdraw_status"),
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun cancel_user_early_stakes<T0>(arg0: &DevAdminCap, arg1: &mut StakingPoolState<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, vector<StakeInfo<T0>>>(&arg1.user_stake_records, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, vector<StakeInfo<T0>>>(&mut arg1.user_stake_records, arg2);
            let v1 = 0;
            while (v1 < 0x1::vector::length<StakeInfo<T0>>(v0)) {
                let v2 = 0x1::vector::borrow_mut<StakeInfo<T0>>(v0, v1);
                let v3 = if (!v2.withdrawn) {
                    if (v2.stake_amount > 0) {
                        v2.early_stake_id != 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    let v4 = StakeCancelEvent{
                        stake_object_id  : 0x2::object::uid_to_inner(&v2.id),
                        user             : arg2,
                        cancelled_amount : v2.stake_amount,
                        cancel_timestamp : now_seconds(arg3),
                        admin            : 0x2::tx_context::sender(arg4),
                        coin_type        : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                    };
                    0x2::event::emit<StakeCancelEvent>(v4);
                    v2.stake_amount = 0;
                    v2.withdrawable_timestamp = 18446744073709551615;
                    v2.withdrawn = true;
                };
                v1 = v1 + 1;
            };
        };
        if (0x2::table::contains<address, u64>(&arg1.user_reward_tokens, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.user_reward_tokens, arg2);
        };
        let v5 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg4),
            action : 0x1::string::utf8(b"cancel_user_stakes"),
        };
        0x2::event::emit<AdminEvent>(v5);
    }

    public fun create_staking_pool<T0>(arg0: &DevAdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1007);
        let v0 = StakingPoolState<T0>{
            id                    : 0x2::object::new(arg2),
            staked_coins_treasury : 0x2::balance::zero<T0>(),
            rewards_treasury      : 0x2::balance::zero<T0>(),
            user_reward_tokens    : 0x2::table::new<address, u64>(arg2),
            user_stake_records    : 0x2::table::new<address, vector<StakeInfo<T0>>>(arg2),
            lock_period           : arg1,
            is_staking_paused     : false,
            is_withdraw_paused    : false,
        };
        0x2::transfer::share_object<StakingPoolState<T0>>(v0);
        let v1 = CreateStakeEvent{
            user      : 0x2::tx_context::sender(arg2),
            type_name : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<CreateStakeEvent>(v1);
    }

    public fun emergency_stop<T0>(arg0: &AdminCap, arg1: &mut StakingPoolState<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<T0>(&arg1.staked_coins_treasury);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.staked_coins_treasury, v1, arg2), v0);
        };
        let v2 = 0x2::balance::value<T0>(&arg1.rewards_treasury);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.rewards_treasury, v2, arg2), v0);
        };
        arg1.is_staking_paused = true;
        arg1.is_withdraw_paused = true;
        let v3 = AdminEvent{
            admin  : 0x2::tx_context::sender(arg2),
            action : 0x1::string::utf8(b"emergency_stop"),
        };
        0x2::event::emit<AdminEvent>(v3);
    }

    public fun get_staking_pool_info<T0>(arg0: &StakingPoolState<T0>) : (u64, u64, u64, bool, bool) {
        (0x2::balance::value<T0>(&arg0.staked_coins_treasury), 0x2::balance::value<T0>(&arg0.rewards_treasury), arg0.lock_period, arg0.is_staking_paused, arg0.is_withdraw_paused)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DevAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DevAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun stake<T0>(arg0: &mut StakingPoolState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_staking_paused, 1009);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= 1000000000, 1008);
        0x2::balance::join<T0>(&mut arg0.staked_coins_treasury, 0x2::coin::into_balance<T0>(arg1));
        let v2 = now_seconds(arg3);
        let v3 = StakeInfo<T0>{
            id                     : 0x2::object::new(arg4),
            stake_amount           : v1,
            stake_timestamp        : v2,
            withdrawable_timestamp : v2 + arg0.lock_period,
            withdrawn              : false,
            early_stake_id         : 0,
        };
        if (!0x2::table::contains<address, vector<StakeInfo<T0>>>(&arg0.user_stake_records, v0)) {
            0x2::table::add<address, vector<StakeInfo<T0>>>(&mut arg0.user_stake_records, v0, 0x1::vector::empty<StakeInfo<T0>>());
        };
        let v4 = 0x2::table::borrow_mut<address, vector<StakeInfo<T0>>>(&mut arg0.user_stake_records, v0);
        assert!(0x1::vector::length<StakeInfo<T0>>(v4) < 1000, 1011);
        let v5 = StakeEvent{
            stake_object_id        : 0x2::object::uid_to_inner(&v3.id),
            user                   : v0,
            amount                 : v1,
            stake_timestamp        : v2,
            withdrawable_timestamp : v3.withdrawable_timestamp,
            early_stake_id         : 0,
            referrer_code          : arg2,
            coin_type              : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<StakeEvent>(v5);
        0x1::vector::push_back<StakeInfo<T0>>(v4, v3);
    }

    public fun withdraw<T0>(arg0: &mut StakingPoolState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_withdraw_paused, 1010);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<StakeInfo<T0>>>(&arg0.user_stake_records, v0), 1002);
        let v1 = 0x2::table::borrow_mut<address, vector<StakeInfo<T0>>>(&mut arg0.user_stake_records, v0);
        let v2 = now_seconds(arg1);
        let v3 = 0;
        let v4 = 0;
        let v5 = WithdrawEventList{events: 0x1::vector::empty<WithdrawEvent>()};
        while (v4 < 0x1::vector::length<StakeInfo<T0>>(v1)) {
            let v6 = 0x1::vector::borrow_mut<StakeInfo<T0>>(v1, v4);
            if (!v6.withdrawn && v2 >= v6.withdrawable_timestamp) {
                v6.withdrawn = true;
                v3 = v3 + v6.stake_amount;
                let v7 = WithdrawEvent{
                    stake_object_id    : 0x2::object::uid_to_inner(&v6.id),
                    user               : v0,
                    withdraw_timestamp : v2,
                    amount             : v6.stake_amount,
                    coin_type          : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
                };
                0x1::vector::push_back<WithdrawEvent>(&mut v5.events, v7);
            };
            v4 = v4 + 1;
        };
        assert!(v3 > 0, 1012);
        assert!(0x2::balance::value<T0>(&arg0.staked_coins_treasury) >= v3, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.staked_coins_treasury, v3, arg2), v0);
        0x2::event::emit<WithdrawEventList>(v5);
    }

    public fun withdraw_reward<T0>(arg0: &mut StakingPoolState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_withdraw_paused, 1010);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.user_reward_tokens, v0), 1006);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_reward_tokens, v0);
        assert!(0x2::balance::value<T0>(&arg0.rewards_treasury) >= v1, 1004);
        0x2::table::remove<address, u64>(&mut arg0.user_reward_tokens, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.rewards_treasury, v1, arg2), v0);
        let v2 = WithdrawRewardEvent{
            user               : v0,
            withdraw_timestamp : now_seconds(arg1),
            reward_amount      : v1,
            coin_type          : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<WithdrawRewardEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

