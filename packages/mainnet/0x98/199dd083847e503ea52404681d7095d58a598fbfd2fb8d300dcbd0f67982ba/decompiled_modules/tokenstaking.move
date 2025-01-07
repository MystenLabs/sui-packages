module 0x98199dd083847e503ea52404681d7095d58a598fbfd2fb8d300dcbd0f67982ba::tokenstaking {
    struct TokenStaking<phantom T0> has key {
        id: 0x2::object::UID,
        dpr: u64,
        sender: address,
        amount: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        obj_id: 0x2::object::ID,
    }

    struct StakingReward<phantom T0> has key {
        id: 0x2::object::UID,
        staker: address,
        amount: 0x2::balance::Balance<T0>,
        withdraw_amount: u64,
        start_time: u64,
    }

    public entry fun create_staking<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = TokenStaking<T0>{
            id     : v0,
            dpr    : arg0,
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<TokenStaking<T0>>(v1);
        let v2 = AdminCap{
            id     : 0x2::object::new(arg2),
            obj_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public entry fun receiver_reward<T0, T1>(arg0: &mut TokenStaking<T0>, arg1: &mut StakingReward<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (200000 - arg1.start_time) * 0x2::balance::value<T1>(&arg1.amount) / 86400 - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v0, arg3), 0x2::tx_context::sender(arg3));
        arg1.withdraw_amount = arg1.withdraw_amount + v0;
    }

    public entry fun stake_token<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &TokenStaking<T1>, arg2: address, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = StakingReward<T0>{
            id              : v0,
            staker          : 0x2::tx_context::sender(arg5),
            amount          : 0x2::coin::into_balance<T0>(arg0),
            withdraw_amount : 0,
            start_time      : 100000,
        };
        0x2::transfer::share_object<StakingReward<T0>>(v1);
        let v2 = AdminCap{
            id     : 0x2::object::new(arg5),
            obj_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg5));
    }

    public entry fun unstake_fund<T0, T1>(arg0: &mut TokenStaking<T0>, arg1: &mut StakingReward<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::balance::value<T1>(&arg1.amount);
        let v2 = (200000 - arg1.start_time) * v1 / 86400 - arg1.withdraw_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.amount, v2, arg3), v0);
        arg1.withdraw_amount = arg1.withdraw_amount + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.amount, v1, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

