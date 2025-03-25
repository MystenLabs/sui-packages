module 0x88a0e68816cc93c61f50fb838c7ca857ad995a82ef9a1b8c2c71c94e03bda8a8::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun get(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

