module 0x25775538ca79a4cb55682e9613c86e7e6df5d5537b9e68f6cb265830cc35c794::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_coin(arg0: TEST_TOKEN, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_TOKEN> {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 9, b"TT", b"TestToken!", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.gstatic.com/kpui/social/x_32x32.png")), arg2);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST_TOKEN>>(v2);
        0x2::coin::mint<TEST_TOKEN>(&mut v2, arg1, arg2)
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_coin(arg0, 1000000000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

