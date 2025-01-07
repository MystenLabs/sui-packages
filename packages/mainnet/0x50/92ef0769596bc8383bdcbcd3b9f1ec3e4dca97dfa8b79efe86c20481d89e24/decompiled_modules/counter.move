module 0x5092ef0769596bc8383bdcbcd3b9f1ec3e4dca97dfa8b79efe86c20481d89e24::counter {
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

