module 0x89b4fc7a0d2a8812375177f4ae8a3115d1199c67999247c13ab9c4275f45f3b8::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

