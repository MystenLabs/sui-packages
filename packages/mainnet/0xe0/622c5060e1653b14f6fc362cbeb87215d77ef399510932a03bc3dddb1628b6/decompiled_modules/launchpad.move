module 0xe0622c5060e1653b14f6fc362cbeb87215d77ef399510932a03bc3dddb1628b6::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

