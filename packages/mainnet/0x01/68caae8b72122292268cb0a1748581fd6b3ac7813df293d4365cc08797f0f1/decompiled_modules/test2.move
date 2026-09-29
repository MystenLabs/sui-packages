module 0x168caae8b72122292268cb0a1748581fd6b3ac7813df293d4365cc08797f0f1::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 9, b"test2", b"test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST2>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

