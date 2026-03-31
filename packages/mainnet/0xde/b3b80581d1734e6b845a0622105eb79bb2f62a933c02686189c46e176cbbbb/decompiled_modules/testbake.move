module 0xdeb3b80581d1734e6b845a0622105eb79bb2f62a933c02686189c46e176cbbbb::testbake {
    struct TESTBAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTBAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTBAKE>(arg0, 9, b"TESTBAKE", b"TESTBAKE", b"Launched via BakerDex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTBAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTBAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

