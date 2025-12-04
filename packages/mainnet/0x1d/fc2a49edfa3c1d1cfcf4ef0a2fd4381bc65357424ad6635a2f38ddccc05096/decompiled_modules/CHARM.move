module 0x1dfc2a49edfa3c1d1cfcf4ef0a2fd4381bc65357424ad6635a2f38ddccc05096::CHARM {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHARM>(arg0, 9, 0x1::string::utf8(b"CHARM"), 0x1::string::utf8(b"Charmastoise"), 0x1::string::utf8(x"546865206c6567656e6461727920506f6bc3a96d6f6e2d696e73706972656420746f6b656e"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHARM>>(0x2::coin_registry::finalize<CHARM>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHARM>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

