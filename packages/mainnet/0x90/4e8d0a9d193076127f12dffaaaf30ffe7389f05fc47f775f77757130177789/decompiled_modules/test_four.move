module 0x904e8d0a9d193076127f12dffaaaf30ffe7389f05fc47f775f77757130177789::test_four {
    struct TEST_FOUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_FOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_FOUR>(arg0, 9, b"test_four", b"test_four", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_FOUR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_FOUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_FOUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

