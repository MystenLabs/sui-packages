module 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::timelock {
    struct Timelock<T0: store> has store, key {
        id: 0x2::object::UID,
        unlock_time: u64,
        data: T0,
    }

    public fun lock<T0: store>(arg0: T0, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Timelock<T0> {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg1), 0);
        Timelock<T0>{
            id          : 0x2::object::new(arg3),
            unlock_time : arg2,
            data        : arg0,
        }
    }

    public fun unlock<T0: store>(arg0: Timelock<T0>, arg1: &0x2::clock::Clock) : T0 {
        let Timelock {
            id          : v0,
            unlock_time : v1,
            data        : v2,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v1, 1);
        0x2::object::delete(v0);
        v2
    }

    public fun unlock_time<T0: store>(arg0: &Timelock<T0>) : u64 {
        arg0.unlock_time
    }

    // decompiled from Move bytecode v6
}

