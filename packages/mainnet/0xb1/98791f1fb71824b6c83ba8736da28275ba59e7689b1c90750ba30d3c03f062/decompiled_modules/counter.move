module 0xb198791f1fb71824b6c83ba8736da28275ba59e7689b1c90750ba30d3c03f062::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public entry fun assert_value(arg0: &Counter, arg1: u64) {
        assert!(arg0.value == arg1, 0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    public fun owner(arg0: &Counter) : address {
        arg0.owner
    }

    public entry fun set_value(arg0: &mut Counter, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.value = arg1;
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

