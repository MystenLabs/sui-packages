module 0xb0e31e4e79db62bede23bd0dd3aefc324b9f6fced7697ccf4b36a10464c69e57::test487895 {
    struct TEST487895 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST487895, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST487895>(arg0, 9, b"TEST487895", b"Test Token 1759892487895", b"Integration test token deployment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST487895>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST487895>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

