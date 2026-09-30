module 0x89e421b411c7bb95e14a162bc13fc5b2e2a52b259f0c6f38826734726ea8a82b::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 9, b"test3", b"test3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST3>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

