module 0x9c4f1209e48ad9b184fe02203a90426b3b3f7fbd415d26b7264ceeac198e6a53::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

