module 0xecd6617ed8461871c327e566e602cd2a9432b57dea7a54910a86a4643e5f4b6b::demo {
    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::bag::Bag>(0x2::bag::new(arg0), 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

