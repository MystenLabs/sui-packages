module 0xc478e4c55ee9beaf131065b912d76266fdf5ec3871d83818c8a00dfa52101e82::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v7
}

