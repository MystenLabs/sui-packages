module 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::lock_coin {
    struct LockedCoin<phantom T0> has key {
        id: 0x2::object::UID,
        lock_ts: u64,
        unlock_ts: u64,
        lock_blance: 0x2::balance::Balance<T0>,
    }

    public fun detail<T0>(arg0: &LockedCoin<T0>) : (u64, u64, u64) {
        (arg0.lock_ts, arg0.unlock_ts, 0x2::balance::value<T0>(&arg0.lock_blance))
    }

    public(friend) fun make_lock_coin<T0>(arg0: address, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedCoin<T0>{
            id          : 0x2::object::new(arg4),
            lock_ts     : arg1,
            unlock_ts   : arg2,
            lock_blance : arg3,
        };
        0x2::transfer::transfer<LockedCoin<T0>>(v0, arg0);
    }

    public(friend) fun unlock_wrapper<T0>(arg0: LockedCoin<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let LockedCoin {
            id          : v0,
            lock_ts     : _,
            unlock_ts   : v2,
            lock_blance : v3,
        } = arg0;
        assert!(v2 < 0x2::clock::timestamp_ms(arg1), 111);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

