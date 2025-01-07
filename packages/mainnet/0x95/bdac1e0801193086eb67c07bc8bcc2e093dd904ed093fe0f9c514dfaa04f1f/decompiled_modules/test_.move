module 0x95bdac1e0801193086eb67c07bc8bcc2e093dd904ed093fe0f9c514dfaa04f1f::test_ {
    struct TEST_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_>(arg0, 9, b"test", b"tesst", b"test no buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_>>(v1);
    }

    // decompiled from Move bytecode v6
}

