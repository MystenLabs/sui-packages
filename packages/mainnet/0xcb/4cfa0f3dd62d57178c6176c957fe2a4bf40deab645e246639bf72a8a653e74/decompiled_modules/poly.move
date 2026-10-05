module 0xcb4cfa0f3dd62d57178c6176c957fe2a4bf40deab645e246639bf72a8a653e74::poly {
    struct POLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POLY>(arg0, 6, 0x1::string::utf8(b"POLY"), 0x1::string::utf8(b"Poly Market"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://popularsui.xyz/media/653e6ccaaac38925b7635ba6fc04c109c857a2ded3c93c2caf38600b1a1ddba6.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POLY>>(0x2::coin_registry::finalize<POLY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

