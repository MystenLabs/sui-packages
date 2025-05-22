module 0xb153c586fe0695141dbeafaa99813c4d3a9cc34fb8434db8ad5c6f76e7375f7e::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun increment(arg0: &mut Counter) {
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

    // decompiled from Move bytecode v6
}

