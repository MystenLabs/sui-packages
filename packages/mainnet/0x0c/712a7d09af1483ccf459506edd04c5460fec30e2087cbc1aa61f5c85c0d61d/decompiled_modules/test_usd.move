module 0xc712a7d09af1483ccf459506edd04c5460fec30e2087cbc1aa61f5c85c0d61d::test_usd {
    struct TEST_USD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_USD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEST_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_USD>(arg0, 6, b"TUSD", b"Test USD", b"Test stablecoin for CashPan testnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TEST_USD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_USD> {
        0x2::coin::mint<TEST_USD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

