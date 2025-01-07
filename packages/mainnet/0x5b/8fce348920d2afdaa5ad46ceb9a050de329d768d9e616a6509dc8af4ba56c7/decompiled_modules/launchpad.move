module 0x5b8fce348920d2afdaa5ad46ceb9a050de329d768d9e616a6509dc8af4ba56c7::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

