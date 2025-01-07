module 0xbe5b88b145988cc7bfc38959062ab9043c0bda18df872ab9ae7d4f79b9d26565::torque_staking {
    struct TorqueStaking<phantom T0> has key {
        id: 0x2::object::UID,
        dpr: u64,
        sender: address,
        amount: 0x2::balance::Balance<T0>,
        duration: u64,
        start_time: u64,
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
    }

    public entry fun create_staking<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = TorqueStaking<T0>{
            id         : v0,
            dpr        : arg0,
            sender     : 0x2::tx_context::sender(arg4),
            amount     : 0x2::coin::into_balance<T0>(arg1),
            duration   : arg2,
            start_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<TorqueStaking<T0>>(v1);
        let v2 = AdminCap{
            id     : 0x2::object::new(arg4),
            obj_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun receiver_reward<T0, T1>(arg0: &mut TorqueStaking<T0>, arg1: &mut TorqueReward<T1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::clock::timestamp_ms(arg2) - arg1.start_time) * 0x2::balance::value<T1>(&arg1.amount) - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v0, arg4), 0x2::tx_context::sender(arg4));
        arg1.withdraw_amount = arg1.withdraw_amount + v0;
    }

    public entry fun stake_token<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &TorqueStaking<T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = TorqueReward<T0>{
            id              : v0,
            staker          : 0x2::tx_context::sender(arg4),
            amount          : 0x2::coin::into_balance<T0>(arg0),
            withdraw_amount : 0,
            start_time      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<TorqueReward<T0>>(v1);
        let v2 = AdminCap{
            id     : 0x2::object::new(arg4),
            obj_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake_fund<T0, T1>(arg0: &mut TorqueStaking<T0>, arg1: &mut TorqueReward<T1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time + arg0.duration, 9223372552250851327);
        let v2 = 0x2::balance::value<T1>(&arg1.amount);
        let v3 = (v1 - arg1.start_time) * v2 - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v3, arg4), v0);
        arg1.withdraw_amount = arg1.withdraw_amount + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.amount, v2, arg4), v0);
    }

    // decompiled from Move bytecode v6
}

