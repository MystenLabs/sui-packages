module 0x8acd6f55447ecb2d2baf580a98f0e0dfec385fc7a2e70e806736ad3049643c27::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 748 || 0x2::tx_context::epoch(arg1) == 749, 1);
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 9, b"test", b"test token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut v2, 1000000000000000000, @0xe89afcbdaf461ff51af1f416183df2316446c1777dfa2ef2e7f97b702266ecbf, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v2, @0xe89afcbdaf461ff51af1f416183df2316446c1777dfa2ef2e7f97b702266ecbf);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

