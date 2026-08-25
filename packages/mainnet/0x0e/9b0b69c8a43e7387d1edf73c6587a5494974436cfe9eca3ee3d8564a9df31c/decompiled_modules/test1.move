module 0xe9b0b69c8a43e7387d1edf73c6587a5494974436cfe9eca3ee3d8564a9df31c::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 6, b"TEST1", b"test 1", b"sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST1>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

