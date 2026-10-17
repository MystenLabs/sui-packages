module 0x9f61a616a44bf912283013092b799dd63b4533a2b377a11b94d0f71308812652::test_usd {
    struct TEST_USD has drop {
        dummy_field: bool,
    }

    struct TestMinted has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_USD>>(0x2::coin::mint<TEST_USD>(arg0, arg1, arg3), arg2);
        let v0 = TestMinted{
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<TestMinted>(v0);
    }

    fun init(arg0: TEST_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_USD>(arg0, 6, b"REKT_TEST_USD", b"REKT TEST USD", b"TEST ONLY - NO VALUE - NOT USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

