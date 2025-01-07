module 0x34ccf407391aaf9a03b56d77139dfffd14c9d8b5b8062b73363a86b5e01b6141::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TESTCOIN_SYMBOL", b"TESTCOIN_NAME", b"TESTCOIN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://TESTCOIN_ICON_URL")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::coin::mint_and_transfer<TESTCOIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

