module 0x7d2cc236bf30ea1e0403a2cd60e986ef7f60632e05702793a7703477f7eaf7f3::playground_simple {
    struct Dummy has key {
        id: 0x2::object::UID,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Dummy>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

