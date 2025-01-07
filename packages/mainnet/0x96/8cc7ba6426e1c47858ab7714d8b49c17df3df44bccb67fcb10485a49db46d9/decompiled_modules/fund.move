module 0x968cc7ba6426e1c47858ab7714d8b49c17df3df44bccb67fcb10485a49db46d9::fund {
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

    public fun verify_signature(arg0: &mut Fund, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::ed25519::ed25519_verify(&arg3, &arg1, &arg2)) {
            arg0.counter = arg0.counter + 1;
        };
    }

    // decompiled from Move bytecode v6
}

