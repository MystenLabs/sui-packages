module 0xaab5a5703bcc912aa0d58a7a739636322572267c7c8523566d57145aa649ea62::locker {
    struct Locker<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        score: u64,
        option: u64,
        current_balance: 0x2::balance::Balance<T0>,
        is_redeemed: bool,
    }

    struct LockEvent has copy, drop {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        score: u64,
    }

    struct UnlockEvent has copy, drop {
        unlock_time: u64,
        original_balance: u64,
    }

    public fun consume_score<T0>(arg0: &mut vector<Locker<T0>>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 2500;
        while (v0 < v2) {
            let v3 = 0x1::vector::borrow_mut<Locker<T0>>(arg0, v1);
            let v4 = v3.score;
            if (v0 + v4 < v2) {
                v0 = v0 + v4;
                v3.score = 0;
            } else {
                let v5 = v2 - v0;
                v0 = v2;
                v3.score = v4 - v5;
            };
            v1 = v1 + 1;
        };
    }

    public fun get_scores<T0>(arg0: &vector<Locker<T0>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Locker<T0>>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<Locker<T0>>(arg0, v1).score;
            v1 = v1 + 1;
        };
        v0
    }

    public fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 4, 0);
        let v0 = 0;
        let v1 = 0;
        if (arg1 == 0) {
            v0 = 10;
        } else if (arg1 == 1) {
            v0 = 100;
            v1 = 604800000;
        } else if (arg1 == 2) {
            v0 = 500;
            v1 = 2592000000;
        } else if (arg1 == 3) {
            v0 = 4000;
            v1 = 15552000000;
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = v2 + v1;
        let v4 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0));
        let v5 = v4 * v0 / 100;
        let v6 = Locker<T0>{
            id               : 0x2::object::new(arg3),
            start_date       : v2,
            final_date       : v3,
            original_balance : v4,
            score            : v5,
            option           : arg1,
            current_balance  : 0x2::coin::into_balance<T0>(arg0),
            is_redeemed      : false,
        };
        0x2::transfer::public_transfer<Locker<T0>>(v6, 0x2::tx_context::sender(arg3));
        let v7 = LockEvent{
            start_date       : v2,
            final_date       : v3,
            original_balance : v4,
            score            : v5,
        };
        0x2::event::emit<LockEvent>(v7);
    }

    public fun unlock<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.final_date - arg0.start_date < v0 - arg0.start_date, 1);
        assert!(arg0.is_redeemed == false, 2);
        let v1 = arg0.original_balance;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.current_balance, v1, arg2), 0x2::tx_context::sender(arg2));
        let v2 = UnlockEvent{
            unlock_time      : v0,
            original_balance : v1,
        };
        0x2::event::emit<UnlockEvent>(v2);
        arg0.is_redeemed = true;
        arg0.score = 0;
    }

    // decompiled from Move bytecode v6
}

