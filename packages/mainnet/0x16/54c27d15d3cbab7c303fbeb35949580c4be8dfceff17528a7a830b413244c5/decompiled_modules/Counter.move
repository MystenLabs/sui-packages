module 0x1654c27d15d3cbab7c303fbeb35949580c4be8dfceff17528a7a830b413244c5::Counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun decrement(arg0: &mut Counter) {
        arg0.value = arg0.value - 1;
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun reset(arg0: &mut Counter) {
        arg0.value = 0;
    }

    // decompiled from Move bytecode v6
}

