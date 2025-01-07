module 0xf01e9ca35762465cfec90f9806bc52c5725217c7aecea05a127489e7d8a0618a::testx {
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

