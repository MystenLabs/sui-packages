module 0xd319da650618c5ba9c626116e676e564881cf6eaa6f877a6c53cf58973c58dab::ALZ {
    struct ALZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALZ>(arg0, 9, 0x1::string::utf8(b"ALZ"), 0x1::string::utf8(b"alfanzapio"), 0x1::string::utf8(b"Alfanzapio flexible utility token for DeFi applications"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ALZ>>(0x2::coin_registry::finalize<ALZ>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALZ>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALZ>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALZ>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

