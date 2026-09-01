module 0x1f417e9686c4718f9645798b8a38baa1631091623d453bbef4198e2c454b83f3::counter {
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

