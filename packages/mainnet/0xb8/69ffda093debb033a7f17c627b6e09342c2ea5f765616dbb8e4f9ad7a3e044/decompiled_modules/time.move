module 0xb869ffda093debb033a7f17c627b6e09342c2ea5f765616dbb8e4f9ad7a3e044::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TIME>(arg0, 6, 0x1::string::utf8(b"TIME"), 0x1::string::utf8(b"Time"), 0x1::string::utf8(b"\"What is more valuable than time?\". A tokenized representation of TIME as a concept, entity, phenomenon, system, or archetype from the world."), 0x1::string::utf8(b"https://popularsui.xyz/media/e99e1a9dc4f923712bdc95de215bf5fa33f2c8cd6ad348280a62a9c70da4ca40.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TIME>>(0x2::coin_registry::finalize<TIME>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

