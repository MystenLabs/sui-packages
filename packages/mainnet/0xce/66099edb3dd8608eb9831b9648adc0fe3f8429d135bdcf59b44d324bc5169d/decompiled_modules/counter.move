module 0xce66099edb3dd8608eb9831b9648adc0fe3f8429d135bdcf59b44d324bc5169d::counter {
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

