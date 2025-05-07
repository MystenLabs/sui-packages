module 0xb4a0605cae91a1fbb27723045e9a12d54e272cf132a4b2fdb292243bd80a603a::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TEST COIN", b"TESTABC", b"A token for test coin metadata update", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTCOIN>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

