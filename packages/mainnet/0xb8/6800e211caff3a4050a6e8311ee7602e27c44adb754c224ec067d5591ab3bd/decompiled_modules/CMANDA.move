module 0xb86800e211caff3a4050a6e8311ee7602e27c44adb754c224ec067d5591ab3bd::CMANDA {
    struct CMANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CMANDA>(arg0, 9, 0x1::string::utf8(b"CMANDA"), 0x1::string::utf8(b"Cmanda"), 0x1::string::utf8(x"546865206f6666696369616c20436d616e646120746f6b656e202d20636f6d6d756e69747920706f776572656420616e6420726561647920746f206d6f6f6e20f09f9a80"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CMANDA>>(0x2::coin_registry::finalize<CMANDA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CMANDA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMANDA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMANDA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

