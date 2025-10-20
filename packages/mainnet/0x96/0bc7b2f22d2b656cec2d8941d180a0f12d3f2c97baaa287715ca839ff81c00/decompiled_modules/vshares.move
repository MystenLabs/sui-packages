module 0x960bc7b2f22d2b656cec2d8941d180a0f12d3f2c97baaa287715ca839ff81c00::vshares {
    struct VSHARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSHARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VSHARES>(arg0, 6, 0x1::string::utf8(b"VSHARES"), 0x1::string::utf8(b"Vault Shares"), 0x1::string::utf8(b"Vault Shares"), 0x1::string::utf8(b"https://example.com/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSHARES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VSHARES>>(0x2::coin_registry::finalize<VSHARES>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

