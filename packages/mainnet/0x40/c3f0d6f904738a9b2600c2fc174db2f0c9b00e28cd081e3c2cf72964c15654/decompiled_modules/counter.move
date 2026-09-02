module 0x40c3f0d6f904738a9b2600c2fc174db2f0c9b00e28cd081e3c2cf72964c15654::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun bump(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    // decompiled from Move bytecode v7
}

