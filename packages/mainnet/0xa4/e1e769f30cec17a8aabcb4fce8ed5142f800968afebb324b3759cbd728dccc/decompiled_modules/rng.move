module 0xa4e1e769f30cec17a8aabcb4fce8ed5142f800968afebb324b3759cbd728dccc::rng {
    struct RNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RNG>(arg0, 6, 0x1::string::utf8(b"RNG"), 0x1::string::utf8(b"RNG bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RNG>>(0x2::coin_registry::finalize<RNG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

