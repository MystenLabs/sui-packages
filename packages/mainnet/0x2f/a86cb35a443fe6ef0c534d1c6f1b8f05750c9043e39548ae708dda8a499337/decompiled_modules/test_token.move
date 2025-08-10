module 0x2fa86cb35a443fe6ef0c534d1c6f1b8f05750c9043e39548ae708dda8a499337::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    struct TestTokenCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TEST_TOKEN>,
    }

    public entry fun burn(arg0: &mut TestTokenCap, arg1: 0x2::coin::Coin<TEST_TOKEN>) {
        0x2::coin::burn<TEST_TOKEN>(&mut arg0.cap, arg1);
    }

    public entry fun mint(arg0: &mut TestTokenCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_TOKEN>>(0x2::coin::mint<TEST_TOKEN>(&mut arg0.cap, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &TestTokenCap) : u64 {
        0x2::coin::total_supply<TEST_TOKEN>(&arg0.cap)
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 6, b"TEST", b"Test Token", b"Test token for Omneon Intent RFQ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
        let v2 = TestTokenCap{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::transfer<TestTokenCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

