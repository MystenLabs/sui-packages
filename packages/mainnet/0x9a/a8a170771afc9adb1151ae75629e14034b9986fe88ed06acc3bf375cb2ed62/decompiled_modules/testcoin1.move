module 0x9aa8a170771afc9adb1151ae75629e14034b9986fe88ed06acc3bf375cb2ed62::testcoin1 {
    struct TESTCOIN1 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN1>>(0x2::coin::mint<TESTCOIN1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: TESTCOIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN1>(arg0, decimals(), b"TEST_COIN_1", b"TEST_COIN_1", b"Native TEST_COIN_1", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

