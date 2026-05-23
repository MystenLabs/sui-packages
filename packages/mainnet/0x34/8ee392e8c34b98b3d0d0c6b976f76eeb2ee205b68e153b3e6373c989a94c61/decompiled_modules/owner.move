module 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

