module 0xf27198c1515b985c3c5761ae0da6e14489e1b86d113d83d1238411a58209ee6::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun getCounter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun incr(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

