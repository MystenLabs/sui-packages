module 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply {
    struct Supply has store, key {
        id: 0x2::object::UID,
        max: u64,
        current: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Supply {
        Supply{
            id      : 0x2::object::new(arg1),
            max     : arg0,
            current : 0,
        }
    }

    public(friend) fun decrement(arg0: &mut Supply, arg1: u64) {
        assert!(arg0.current >= arg1, 1);
        arg0.current = arg0.current - arg1;
    }

    public fun get_current(arg0: &Supply) : u64 {
        arg0.current
    }

    public fun get_max(arg0: &Supply) : u64 {
        arg0.max
    }

    public fun get_remaining(arg0: &Supply) : u64 {
        arg0.max - arg0.current
    }

    public(friend) fun increment(arg0: &mut Supply, arg1: u64) {
        assert!(arg0.current + arg1 <= arg0.max, 0);
        arg0.current = arg0.current + arg1;
    }

    // decompiled from Move bytecode v6
}

