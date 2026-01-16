module 0x34231c2fb0ed0a0999ac06d209835e82ad75e1cdf381089caf548d07e1addb66::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

