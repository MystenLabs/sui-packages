module 0x8eb77c0f0225d7c25465258f76f23645e9db2d62c65ad1623d6fe50558504a34::CHOCO {
    struct CHOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHOCO>(arg0, 9, 0x1::string::utf8(b"CHOCO"), 0x1::string::utf8(b"ChocoBoy"), 0x1::string::utf8(b"The sweetest chocolate-themed token on Sui - once minted, forever delicious!"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHOCO>>(0x2::coin_registry::finalize<CHOCO>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHOCO>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCO>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCO>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

