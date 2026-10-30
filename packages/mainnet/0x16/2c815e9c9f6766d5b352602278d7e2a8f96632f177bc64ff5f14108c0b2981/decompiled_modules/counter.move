module 0x162c815e9c9f6766d5b352602278d7e2a8f96632f177bc64ff5f14108c0b2981::counter {
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
        0x2::transfer::transfer<Counter>(v0, @0xc7c87b6e2cdb0756d359a88a49a69af7ce11e7faff85a087940dc28b30924573);
    }

    public fun value(arg0: &Counter) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

