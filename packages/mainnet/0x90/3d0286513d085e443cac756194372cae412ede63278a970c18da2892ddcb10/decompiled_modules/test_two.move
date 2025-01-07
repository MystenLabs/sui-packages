module 0x903d0286513d085e443cac756194372cae412ede63278a970c18da2892ddcb10::test_two {
    struct TEST_TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TWO>(arg0, 9, b"test_two", b"test_two", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TWO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

