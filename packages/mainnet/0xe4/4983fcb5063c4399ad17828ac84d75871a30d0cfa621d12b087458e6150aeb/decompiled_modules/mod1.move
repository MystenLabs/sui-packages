module 0xe44983fcb5063c4399ad17828ac84d75871a30d0cfa621d12b087458e6150aeb::mod1 {
    struct First has store, key {
        id: 0x2::object::UID,
    }

    public fun make_first(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = First{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<First>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

