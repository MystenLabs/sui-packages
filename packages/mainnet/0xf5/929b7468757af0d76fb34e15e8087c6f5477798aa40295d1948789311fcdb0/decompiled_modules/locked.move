module 0xf5929b7468757af0d76fb34e15e8087c6f5477798aa40295d1948789311fcdb0::locked {
    struct Locked<T0: store> has store, key {
        id: 0x2::object::UID,
        inner: T0,
        lock_end_timestamp_ms: u64,
    }

    public fun borrow<T0: store>(arg0: &Locked<T0>) : &T0 {
        &arg0.inner
    }

    public(friend) fun borrow_mut<T0: store>(arg0: &mut Locked<T0>) : &mut T0 {
        &mut arg0.inner
    }

    public(friend) fun new<T0: store>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Locked<T0> {
        Locked<T0>{
            id                    : 0x2::object::new(arg2),
            inner                 : arg0,
            lock_end_timestamp_ms : arg1,
        }
    }

    public(friend) fun force_unlock<T0: store>(arg0: Locked<T0>) : T0 {
        let Locked {
            id                    : v0,
            inner                 : v1,
            lock_end_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun is_unlocked<T0: store>(arg0: &Locked<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.lock_end_timestamp_ms <= 0x2::clock::timestamp_ms(arg1)
    }

    public fun lock<T0: store>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Locked<T0> {
        new<T0>(arg0, 0x2::clock::timestamp_ms(arg1) + arg2, arg3)
    }

    public fun lock_end_timestamp_ms<T0: store>(arg0: &Locked<T0>) : u64 {
        arg0.lock_end_timestamp_ms
    }

    public fun maybe_unlock_and_keep<T0: store + key>(arg0: Locked<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        if (is_unlocked<T0>(&arg0, arg1)) {
            0x2::transfer::public_transfer<T0>(force_unlock<T0>(arg0), 0x2::tx_context::sender(arg2));
        } else {
            0x2::transfer::transfer<Locked<T0>>(arg0, 0x2::tx_context::sender(arg2));
        };
    }

    public fun maybe_unlock_and_transfer<T0: store + key>(arg0: Locked<T0>, arg1: &0x2::clock::Clock, arg2: address) {
        if (is_unlocked<T0>(&arg0, arg1)) {
            0x2::transfer::public_transfer<T0>(force_unlock<T0>(arg0), arg2);
        } else {
            0x2::transfer::transfer<Locked<T0>>(arg0, arg2);
        };
    }

    public(friend) fun set_lock_end_timestamp_ms<T0: store>(arg0: &mut Locked<T0>, arg1: u64) {
        assert!(arg0.lock_end_timestamp_ms <= arg1, 13835340208863838211);
        arg0.lock_end_timestamp_ms = arg1;
    }

    public fun unlock<T0: store>(arg0: Locked<T0>, arg1: &0x2::clock::Clock) : T0 {
        unlock_<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun unlock_<T0: store>(arg0: Locked<T0>, arg1: u64) : T0 {
        assert!(arg0.lock_end_timestamp_ms <= arg1, 13835058884210851841);
        let Locked {
            id                    : v0,
            inner                 : v1,
            lock_end_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

