module 0x4684aaacef52d58a4fbb3701e42d8c5f901189802dc4ee8ec697104112613bf4::vshares {
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

