module 0xab5ec9bbbc6bd5192bb9c4c1ed3476d519ea5c5c159d288dd9b39f4fd32f7264::config {
    struct AirdropConfigCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AirdropConfigCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

