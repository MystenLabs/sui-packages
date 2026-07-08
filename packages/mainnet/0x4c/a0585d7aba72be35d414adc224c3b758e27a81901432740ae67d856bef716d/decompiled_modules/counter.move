module 0x4ca0585d7aba72be35d414adc224c3b758e27a81901432740ae67d856bef716d::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun decrement(arg0: &mut Counter) {
        if (arg0.value > 0) {
            arg0.value = arg0.value - 1;
        };
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun reset(arg0: &mut Counter) {
        arg0.value = 0;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

