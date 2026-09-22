module 0xfe33d15983698d59687e8c65ef494cb81574697b3ca6c4df5f97c7412eceedba::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 9, b"ANON", b"ANON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/76907b24149c067e2a47e0697eb09efc7b5672434a42d82343b5678eec6fc359?r=2")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ANON>>(0x2::coin::mint<ANON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

