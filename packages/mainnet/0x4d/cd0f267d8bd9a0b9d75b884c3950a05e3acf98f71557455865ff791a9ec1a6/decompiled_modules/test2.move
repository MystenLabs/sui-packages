module 0x4dcd0f267d8bd9a0b9d75b884c3950a05e3acf98f71557455865ff791a9ec1a6::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 9, b"test2", b"test2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST2>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

