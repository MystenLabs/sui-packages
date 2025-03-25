module 0x899547f7a34294750ed8d81f3678f7fc51dfc7acdc16b0a709abe0cdf4396074::counter {
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

