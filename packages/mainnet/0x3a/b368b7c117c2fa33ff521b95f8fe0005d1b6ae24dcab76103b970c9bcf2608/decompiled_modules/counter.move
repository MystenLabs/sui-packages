module 0x3ab368b7c117c2fa33ff521b95f8fe0005d1b6ae24dcab76103b970c9bcf2608::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<Counter>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

