module 0x9a93f32bff34960d79c2dfbdd2d81cf7d4dd63ef46128cbab10e6497dd1045dd::tests {
    struct TESTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTS>(arg0, 6, b"TESTS", b"test", b"ASDASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifp7vikcbdknupudjetcx5oujfadfmfytwi5bvk37qqndue6fp2u4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

