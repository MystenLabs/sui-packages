module 0xa202ef892decf142e5472ff8d1ff42ef506d8f5db7598dbb6097557783612767::testc {
    struct TESTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTC>(arg0, 9, b"TESTC", b"TESTC", b"TESTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/gFlZ82NToPW-dTzuhMu8hyNCjzRmBUd3Eo7d1g2Q-oU")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTC>>(0x2::coin::mint<TESTC>(&mut v2, 3000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTC>>(v1);
    }

    // decompiled from Move bytecode v7
}

