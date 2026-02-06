module 0xff4f1086f9acc3bf57f0ad89991ecc874e24b69275e353f6f02f9ade60f24524::staking {
    struct StakeEvent has copy, drop {
        staker: address,
        amount: u64,
        duration: u64,
        stake_id: address,
    }

    struct UnstakeEvent has copy, drop {
        staker: address,
        amount: u64,
        credits_earned: u64,
    }

    struct StakeReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start_timestamp: u64,
        duration: u64,
        multiplier: u64,
        original_amount: u64,
    }

    public entry fun stake<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (arg1 == 604800000) {
            100
        } else if (arg1 == 2592000000) {
            150
        } else {
            assert!(arg1 == 7776000000, 0);
            200
        };
        let v2 = StakeReceipt<T0>{
            id              : 0x2::object::new(arg3),
            balance         : 0x2::coin::into_balance<T0>(arg0),
            start_timestamp : 0x2::clock::timestamp_ms(arg2),
            duration        : arg1,
            multiplier      : v1,
            original_amount : v0,
        };
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = StakeEvent{
            staker   : v3,
            amount   : v0,
            duration : arg1,
            stake_id : 0x2::object::uid_to_address(&v2.id),
        };
        0x2::event::emit<StakeEvent>(v4);
        0x2::transfer::public_transfer<StakeReceipt<T0>>(v2, v3);
    }

    public entry fun unstake<T0>(arg0: StakeReceipt<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let StakeReceipt {
            id              : v0,
            balance         : v1,
            start_timestamp : v2,
            duration        : v3,
            multiplier      : v4,
            original_amount : v5,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v2 + v3, 1);
        let v6 = 0x2::tx_context::sender(arg2);
        let v7 = UnstakeEvent{
            staker         : v6,
            amount         : v5,
            credits_earned : v5 * v4 / 100,
        };
        0x2::event::emit<UnstakeEvent>(v7);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), v6);
    }

    // decompiled from Move bytecode v6
}

