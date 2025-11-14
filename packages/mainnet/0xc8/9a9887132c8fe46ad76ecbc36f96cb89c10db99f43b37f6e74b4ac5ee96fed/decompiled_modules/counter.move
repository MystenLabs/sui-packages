module 0xc89a9887132c8fe46ad76ecbc36f96cb89c10db99f43b37f6e74b4ac5ee96fed::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun decrement(arg0: &mut Counter) {
        if (arg0.value > 0) {
            arg0.value = arg0.value - 1;
        };
    }

    public fun get_value(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun reset(arg0: &mut Counter) {
        arg0.value = 0;
    }

    // decompiled from Move bytecode v6
}

