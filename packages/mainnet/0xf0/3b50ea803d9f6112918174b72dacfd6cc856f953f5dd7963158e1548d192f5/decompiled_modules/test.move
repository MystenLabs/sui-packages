module 0xf03b50ea803d9f6112918174b72dacfd6cc856f953f5dd7963158e1548d192f5::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"Test", b"Test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

