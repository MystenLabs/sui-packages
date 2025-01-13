module 0x2c9005fa89f5704adee7881f5e9bb34c72d8b864d00d6c0cb9615b358b18a205::fund {
    struct Fund has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    public(friend) fun create_fund(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Fund{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::share_object<Fund>(v0);
    }

    public fun ex2(arg0: &mut Fund, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
    }

    // decompiled from Move bytecode v6
}

