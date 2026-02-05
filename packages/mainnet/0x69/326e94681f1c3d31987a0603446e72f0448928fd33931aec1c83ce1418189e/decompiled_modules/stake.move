module 0x69326e94681f1c3d31987a0603446e72f0448928fd33931aec1c83ce1418189e::stake {
    struct Staker<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        lender: address,
        start_time: u64,
    }

    struct StakeAdded<phantom T0> has copy, drop, store {
        id: address,
        lender: address,
        amount: u64,
        start_time: u64,
    }

    struct StakeWithdrawn<phantom T0> has copy, drop, store {
        id: address,
        lender: address,
        withdraw_time: u64,
        amount_withdrawn: u64,
    }

    public entry fun GetStakeInfo<T0>(arg0: &Staker<T0>) : (address, u64, u64) {
        (arg0.lender, 0x2::balance::value<T0>(&arg0.balance), arg0.start_time)
    }

    public entry fun Stake<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::coin::into_balance<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x2::object::new(arg2);
        assert!(v3 > 0, 2);
        let v5 = Staker<T0>{
            id         : v4,
            balance    : v2,
            lender     : v1,
            start_time : v0,
        };
        0x2::transfer::transfer<Staker<T0>>(v5, v1);
        let v6 = StakeAdded<T0>{
            id         : 0x2::object::uid_to_address(&v4),
            lender     : v1,
            amount     : v3,
            start_time : v0,
        };
        0x2::event::emit<StakeAdded<T0>>(v6);
    }

    public entry fun Withdraw<T0>(arg0: Staker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let Staker {
            id         : v1,
            balance    : v2,
            lender     : _,
            start_time : _,
        } = arg0;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v5, v6, arg2), v0);
        let v7 = StakeWithdrawn<T0>{
            id               : 0x2::object::uid_to_address(&arg0.id),
            lender           : v0,
            withdraw_time    : 0x2::clock::timestamp_ms(arg1),
            amount_withdrawn : v6,
        };
        0x2::event::emit<StakeWithdrawn<T0>>(v7);
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

