module 0x5f5dd23997aa314447677b8992aabf4e4700ed946c3348bf71c54f999dd6d1d9::lock {
    struct Locker<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        lender: address,
        start_time: u64,
        duration: u64,
    }

    struct LoanCreated<phantom T0> has copy, drop, store {
        lender: address,
        amount: u64,
        start_time: u64,
        duration: u64,
    }

    struct LoanWithdrawn<phantom T0> has copy, drop, store {
        lender: address,
        withdraw_time: u64,
        amount_withdrawn: u64,
    }

    public entry fun get_locker_info<T0>(arg0: &Locker<T0>) : (address, u64, u64, u64) {
        (arg0.lender, 0x2::balance::value<T0>(&arg0.balance), arg0.start_time, arg0.duration)
    }

    public entry fun lend<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(arg1 <= 525600, 3);
        let v0 = arg1 * 60000;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::coin::into_balance<T0>(arg0);
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(v4 > 0, 2);
        let v5 = Locker<T0>{
            id         : 0x2::object::new(arg3),
            balance    : v3,
            lender     : v2,
            start_time : v1,
            duration   : v0,
        };
        0x2::transfer::transfer<Locker<T0>>(v5, v2);
        let v6 = LoanCreated<T0>{
            lender     : v2,
            amount     : v4,
            start_time : v1,
            duration   : v0,
        };
        0x2::event::emit<LoanCreated<T0>>(v6);
    }

    public entry fun withdraw_loan<T0>(arg0: Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 >= arg0.start_time + arg0.duration, 1);
        let Locker {
            id         : v2,
            balance    : v3,
            lender     : _,
            start_time : _,
            duration   : _,
        } = arg0;
        let v7 = v3;
        let v8 = 0x2::balance::value<T0>(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v7, v8, arg2), v1);
        let v9 = LoanWithdrawn<T0>{
            lender           : v1,
            withdraw_time    : v0,
            amount_withdrawn : v8,
        };
        0x2::event::emit<LoanWithdrawn<T0>>(v9);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

