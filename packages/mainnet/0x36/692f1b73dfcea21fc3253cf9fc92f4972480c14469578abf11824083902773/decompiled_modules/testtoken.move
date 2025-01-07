module 0x36692f1b73dfcea21fc3253cf9fc92f4972480c14469578abf11824083902773::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: 0x2::coin::Coin<TESTTOKEN>) {
        0x2::coin::burn<TESTTOKEN>(arg0, arg1);
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 9, b"TESTTICKER", b"TESTTOKEN", b"testing a fuckin token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

