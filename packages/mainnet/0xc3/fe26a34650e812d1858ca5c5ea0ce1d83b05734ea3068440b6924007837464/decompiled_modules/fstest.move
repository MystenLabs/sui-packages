module 0xc3fe26a34650e812d1858ca5c5ea0ce1d83b05734ea3068440b6924007837464::fstest {
    struct FSTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://formion.ai/logo-cdn/studio/863cd98a0933f621a2a384819b2e27e2.png";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://formion.ai/logo-cdn/studio/863cd98a0933f621a2a384819b2e27e2.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<FSTEST>(arg0, 9, b"FSTEST", b"Formion Studio Test", b"Formion Contract Studio mainnet test token (internal test, not for trading).", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<FSTEST>(&mut v4, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSTEST>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FSTEST>>(v4);
    }

    // decompiled from Move bytecode v7
}

