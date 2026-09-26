module 0xb0e0b3c50264c5eafee36ae2153f59c703f9aa7ac8e4216e44c497e1e8e8f217::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TIME>(arg0, 6, 0x1::string::utf8(b"TIME"), 0x1::string::utf8(b"Time"), 0x1::string::utf8(b"\"What is more valuable than time?\". A tokenized representation of TIME as a concept, entity, phenomenon, system, or archetype from the world."), 0x1::string::utf8(b"https://popularsui.xyz/media/95b47bf9c52ba952d03a325caba2c5a468ff3e15cae9e50c53355bdf677819d5.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TIME>>(0x2::coin_registry::finalize<TIME>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

