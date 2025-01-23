module 0x48f456fafbc8c24b5ba496b429529f9881b0a3d9459b4495c7db9e3e6cdfa0ca::locked_coin {
    struct Locker<T0: store + key> has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        current_balance: 0x2::balance::Balance<T0>,
    }

    public fun lock<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Locker<T0>{
            id               : 0x2::object::new(arg4),
            start_date       : v0,
            final_date       : v0 + arg2,
            original_balance : arg1,
            current_balance  : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::public_transfer<Locker<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun withdraw_vested<T0: store + key>(arg0: &mut Locker<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.final_date - arg0.start_date;
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.start_date;
        let v2 = if (v1 > v0) {
            arg0.original_balance
        } else {
            arg0.original_balance * v1 / v0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.current_balance, v2 - arg0.original_balance - 0x2::balance::value<T0>(&arg0.current_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

