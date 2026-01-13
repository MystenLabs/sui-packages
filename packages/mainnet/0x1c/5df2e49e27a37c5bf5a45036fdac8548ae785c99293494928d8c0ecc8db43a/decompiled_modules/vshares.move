module 0x1c5df2e49e27a37c5bf5a45036fdac8548ae785c99293494928d8c0ecc8db43a::vshares {
    struct VSHARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSHARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VSHARES>(arg0, 6, 0x1::string::utf8(b"vSHARES"), 0x1::string::utf8(b"Suilend Vault Shares"), 0x1::string::utf8(b"Suilend Vault Shares"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSHARES>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VSHARES>>(0x2::coin_registry::finalize<VSHARES>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

