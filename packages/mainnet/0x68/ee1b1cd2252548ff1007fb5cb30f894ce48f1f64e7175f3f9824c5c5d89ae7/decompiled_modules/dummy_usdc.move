module 0x68ee1b1cd2252548ff1007fb5cb30f894ce48f1f64e7175f3f9824c5c5d89ae7::dummy_usdc {
    struct DUMMY_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DUMMY_USDC>(arg0, 6, 0x1::string::utf8(b"DUMMY_USDC"), 0x1::string::utf8(b"DUMMY_USDC"), 0x1::string::utf8(b"DUMMY_USDC"), 0x1::string::utf8(b"https://example.com/icon.png"), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMY_USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DUMMY_USDC>>(0x2::coin_registry::make_regulated<DUMMY_USDC>(&mut v2, true, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DUMMY_USDC>>(0x2::coin_registry::finalize<DUMMY_USDC>(v2, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

