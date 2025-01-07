module 0x7cd04d8756b4e9e904c7b7ec9510be520d1a3d9342436842b185ba022d0f4451::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

