module 0x364f1adc5c4529e7c21379fbd6e04aa0fe0e50dc47f0855fb200624cf2b53e87::example {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0);
        0x2::transfer::public_transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

