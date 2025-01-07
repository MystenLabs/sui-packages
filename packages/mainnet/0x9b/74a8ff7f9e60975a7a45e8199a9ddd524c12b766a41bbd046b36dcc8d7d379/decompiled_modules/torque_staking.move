module 0x9b74a8ff7f9e60975a7a45e8199a9ddd524c12b766a41bbd046b36dcc8d7d379::torque_staking {
    struct TorqueStaking<phantom T0> has key {
        id: 0x2::object::UID,
        dpr: u64,
        sender: address,
        amount: 0x2::balance::Balance<T0>,
        duration: u64,
        start_time: u64,
        claim_interval: u64,
        total_staked: u64,
        max_stake: u64,
        total_capacity: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        obj_id: 0x2::object::ID,
    }

    struct TorqueReward<phantom T0> has key {
        id: 0x2::object::UID,
        staker: address,
        amount: 0x2::balance::Balance<T0>,
        withdraw_amount: u64,
        start_time: u64,
        last_claim_time: u64,
    }

    public entry fun add_rewards<T0>(arg0: &mut TorqueStaking<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.sender, 8);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun create_staking<T0>(arg0: u64, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg2 > 0, 1);
        assert!(arg0 > 0 && arg0 <= 10000, 2);
        assert!(arg3 > 0, 3);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 0);
        let v1 = 0x2::object::new(arg8);
        let v2 = TorqueStaking<T0>{
            id             : v1,
            dpr            : arg0,
            sender         : v0,
            amount         : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg8)),
            duration       : arg3,
            start_time     : 0x2::clock::timestamp_ms(arg7),
            claim_interval : arg4,
            total_staked   : 0,
            max_stake      : arg5,
            total_capacity : arg6,
        };
        0x2::transfer::share_object<TorqueStaking<T0>>(v2);
        let v3 = AdminCap{
            id     : 0x2::object::new(arg8),
            obj_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
    }

    public entry fun receive_reward<T0, T1>(arg0: &mut TorqueStaking<T0>, arg1: &mut TorqueReward<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.staker, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg1.last_claim_time + arg0.claim_interval, 7);
        let v2 = (v1 - arg1.start_time) * 0x2::balance::value<T1>(&arg1.amount) * arg0.dpr / 864000000 - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v2, arg3), v0);
        arg1.withdraw_amount = arg1.withdraw_amount + v2;
        arg1.last_claim_time = v1;
    }

    public entry fun stake_token<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut TorqueStaking<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
        assert!(arg2.total_staked + arg1 <= arg2.total_capacity, 9);
        assert!(arg1 <= arg2.max_stake, 10);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = TorqueReward<T0>{
            id              : v1,
            staker          : v0,
            amount          : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg4)),
            withdraw_amount : 0,
            start_time      : v2,
            last_claim_time : v2,
        };
        0x2::transfer::share_object<TorqueReward<T0>>(v3);
        arg2.total_staked = arg2.total_staked + arg1;
        let v4 = AdminCap{
            id     : 0x2::object::new(arg4),
            obj_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::public_transfer<AdminCap>(v4, v0);
    }

    public entry fun unstake_fund<T0, T1>(arg0: &mut TorqueStaking<T0>, arg1: &mut TorqueReward<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.staker, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time + arg0.duration, 5);
        let v2 = 0x2::balance::value<T1>(&arg1.amount);
        let v3 = (v1 - arg1.start_time) * v2 * arg0.dpr / 864000000 - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v3, arg3), v0);
        arg1.withdraw_amount = arg1.withdraw_amount + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.amount, v2, arg3), v0);
    }

    public entry fun withdraw_excess_rewards<T0>(arg0: &mut TorqueStaking<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.sender, 8);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time + arg0.duration, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, 0x2::balance::value<T0>(&arg0.amount), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

