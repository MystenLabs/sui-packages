module 0x5a08996b1bf7d62c23eb72cef5c41d67d0824d8d42dd48c5ee7dad98b8d083c6::locked_coin {
    struct Locker<T0> has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        final_date: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun lock<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = Locker<T0>{
            id         : 0x2::object::new(arg3),
            start_date : v0,
            final_date : v0 + arg1,
            balance    : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::public_transfer<Locker<T0>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_vested<T0>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.final_date <= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

