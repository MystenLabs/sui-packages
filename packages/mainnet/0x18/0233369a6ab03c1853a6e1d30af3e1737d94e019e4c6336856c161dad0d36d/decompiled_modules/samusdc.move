module 0x180233369a6ab03c1853a6e1d30af3e1737d94e019e4c6336856c161dad0d36d::samusdc {
    struct SAMUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMUSDC>(arg0, 6, 0x1::string::utf8(b"samUSDC"), 0x1::string::utf8(b"Sam USDC"), 0x1::string::utf8(b"Sam USDC"), 0x1::string::utf8(b"https://usesam.xyz/tokens/samusdc.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMUSDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMUSDC>>(0x2::coin_registry::finalize<SAMUSDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

