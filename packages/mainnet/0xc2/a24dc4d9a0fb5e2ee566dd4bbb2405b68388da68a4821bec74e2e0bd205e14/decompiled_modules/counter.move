module 0xc2a24dc4d9a0fb5e2ee566dd4bbb2405b68388da68a4821bec74e2e0bd205e14::counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun create_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_count(arg0: &Counter) : u64 {
        arg0.count
    }

    public fun increment(arg0: &mut Counter) {
        arg0.count = arg0.count + 1;
    }

    // decompiled from Move bytecode v6
}

