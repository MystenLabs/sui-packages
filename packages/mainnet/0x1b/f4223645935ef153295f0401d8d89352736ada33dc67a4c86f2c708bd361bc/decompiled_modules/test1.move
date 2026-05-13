module 0x1bf4223645935ef153295f0401d8d89352736ada33dc67a4c86f2c708bd361bc::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"Test1", b"smoke-test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flopfun.vercel.app/icon/32d3537b-0912-49d7-81a8-8965a9d74188.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST1>>(0x2::coin::mint<TEST1>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST1>>(v2);
    }

    // decompiled from Move bytecode v7
}

