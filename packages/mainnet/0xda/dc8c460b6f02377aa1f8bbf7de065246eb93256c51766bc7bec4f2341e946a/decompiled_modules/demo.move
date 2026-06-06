module 0xdadc8c460b6f02377aa1f8bbf7de065246eb93256c51766bc7bec4f2341e946a::demo {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create_shared_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun increase(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

