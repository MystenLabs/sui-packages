module 0xbe66e3956632c8b8cb90211ecb329b9bb03afef9ba5d72472a7c240d3afe19fd::fund {
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

