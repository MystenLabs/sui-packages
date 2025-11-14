module 0xd57fc64aeac1f7d16ce028dd6c7a6a8e3f91b9258af46fcef535775fab4efe26::contador {
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

