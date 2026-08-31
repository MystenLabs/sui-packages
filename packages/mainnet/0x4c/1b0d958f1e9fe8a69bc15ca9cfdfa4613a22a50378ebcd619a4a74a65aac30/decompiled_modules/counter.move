module 0x4c1b0d958f1e9fe8a69bc15ca9cfdfa4613a22a50378ebcd619a4a74a65aac30::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun bump(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

