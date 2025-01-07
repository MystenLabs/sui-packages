module 0x40f822f6a2fe61e3f918e73a35e80e1ae79c7aef0d1e2e900bd5fb37ceec4353::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: 0x2::coin::Coin<TEST_TOKEN>) {
        0x2::coin::burn<TEST_TOKEN>(arg0, arg1);
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"https://i.imgur.com/Y8OIuGF.png");
        let (v1, v2) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 2, b"TTK", b"TEST_TOKEN", b"xzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v0))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

