module 0x6aa4d2f11c07bc02340ff21f88bf7e9931b93b36bdb0cc0c8b194ed5c2259b32::testx {
    struct TESTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTX>(arg0, 6, b"TESTX", b"Test X", b"Just testing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_e24bf878d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

