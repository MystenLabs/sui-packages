module 0x2db1de090f770991849ae3c81104b4e51c6f801095ce838ff8b8c96e3fa8c806::samusdc {
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

