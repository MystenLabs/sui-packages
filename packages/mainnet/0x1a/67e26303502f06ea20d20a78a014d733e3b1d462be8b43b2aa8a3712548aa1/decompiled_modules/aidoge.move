module 0x1a67e26303502f06ea20d20a78a014d733e3b1d462be8b43b2aa8a3712548aa1::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 9, b"AIDOGE", b"Sui AIDoge", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIDOGE>(&mut v2, 100000000000000000, @0xadc854790c0a6de08e0346980e9fb6fa21af1b46436c1410cb85f8680ff4d88e, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

