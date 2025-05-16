module 0xdafc370f870649da8456a0c5d07e0f79e9be06d6ea2fb0e70fabb7370a1fb281::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    struct TestTokenTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TEST_TOKEN>,
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 0, b"TEST", b"TEST", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = TestTokenTreasury{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::freeze_object<TestTokenTreasury>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

