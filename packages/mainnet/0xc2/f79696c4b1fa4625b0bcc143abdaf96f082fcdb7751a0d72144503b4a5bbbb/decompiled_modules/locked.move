module 0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked {
    struct Locked<T0: store> has store, key {
        id: 0x2::object::UID,
        inner: T0,
        lock_end_timestamp_ms: u64,
    }

    public fun borrow<T0: store>(arg0: &Locked<T0>) : &T0 {
        &arg0.inner
    }

    public fun is_unlocked<T0: store>(arg0: &Locked<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.lock_end_timestamp_ms <= 0x2::clock::timestamp_ms(arg1)
    }

    public fun lock<T0: store>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Locked<T0> {
        Locked<T0>{
            id                    : 0x2::object::new(arg3),
            inner                 : arg0,
            lock_end_timestamp_ms : 0x2::clock::timestamp_ms(arg1) + arg2,
        }
    }

    public fun lock_end_timestamp_ms<T0: store>(arg0: &Locked<T0>) : u64 {
        arg0.lock_end_timestamp_ms
    }

    public fun unlock<T0: store>(arg0: Locked<T0>, arg1: &0x2::clock::Clock) : T0 {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.lock_end_timestamp_ms, 0);
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

