module 0x119c87d56bd17fc3c5713717c8cd50312b0ef181f555723ab3bc1facf9f48e2d::stake {
    struct Stake<phantom T0> has key {
        id: 0x2::object::UID,
        payer: address,
        beneficiary: address,
        arbiter: address,
        deadline_ms: u64,
        promise: vector<u8>,
        funds: 0x2::balance::Balance<T0>,
    }

    struct Staked has copy, drop {
        stake_id: 0x2::object::ID,
        payer: address,
        beneficiary: address,
        arbiter: address,
        amount: u64,
        deadline_ms: u64,
        promise: vector<u8>,
    }

    struct Settled has copy, drop {
        stake_id: 0x2::object::ID,
        kept: bool,
        to: address,
        amount: u64,
    }

    struct Reclaimed has copy, drop {
        stake_id: 0x2::object::ID,
        payer: address,
        amount: u64,
    }

    public fun amount<T0>(arg0: &Stake<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun arbiter<T0>(arg0: &Stake<T0>) : address {
        arg0.arbiter
    }

    public fun beneficiary<T0>(arg0: &Stake<T0>) : address {
        arg0.beneficiary
    }

    public fun create<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 3);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg5), 4);
        assert!(arg1 != 0x2::tx_context::sender(arg6), 5);
        let v1 = Stake<T0>{
            id          : 0x2::object::new(arg6),
            payer       : 0x2::tx_context::sender(arg6),
            beneficiary : arg1,
            arbiter     : arg2,
            deadline_ms : arg3,
            promise     : arg4,
            funds       : 0x2::coin::into_balance<T0>(arg0),
        };
        let v2 = Staked{
            stake_id    : 0x2::object::id<Stake<T0>>(&v1),
            payer       : v1.payer,
            beneficiary : arg1,
            arbiter     : arg2,
            amount      : v0,
            deadline_ms : arg3,
            promise     : v1.promise,
        };
        0x2::event::emit<Staked>(v2);
        0x2::transfer::share_object<Stake<T0>>(v1);
    }

    public fun deadline_ms<T0>(arg0: &Stake<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun payer<T0>(arg0: &Stake<T0>) : address {
        arg0.payer
    }

    public fun promise<T0>(arg0: &Stake<T0>) : vector<u8> {
        arg0.promise
    }

    public fun reclaim<T0>(arg0: Stake<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms + 604800000, 2);
        let Stake {
            id          : v0,
            payer       : v1,
            beneficiary : _,
            arbiter     : _,
            deadline_ms : _,
            promise     : _,
            funds       : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v0;
        let v9 = Reclaimed{
            stake_id : 0x2::object::uid_to_inner(&v8),
            payer    : v1,
            amount   : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<Reclaimed>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v1);
        0x2::object::delete(v8);
    }

    public fun settle<T0>(arg0: Stake<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.arbiter, 1);
        let Stake {
            id          : v0,
            payer       : v1,
            beneficiary : v2,
            arbiter     : _,
            deadline_ms : _,
            promise     : _,
            funds       : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v0;
        let v9 = if (arg1) {
            v1
        } else {
            v2
        };
        let v10 = Settled{
            stake_id : 0x2::object::uid_to_inner(&v8),
            kept     : arg1,
            to       : v9,
            amount   : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<Settled>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v9);
        0x2::object::delete(v8);
    }

    // decompiled from Move bytecode v7
}

