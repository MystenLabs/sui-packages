module 0x9e2827f1b56b08c14ba8bd4d6ec4b5c5a847f1aaf35b47fa3ceeedb0f5656404::testtools3 {
    struct TESTTOOLS3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOOLS3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 799 || 0x2::tx_context::epoch(arg1) == 800, 1);
        let (v0, v1) = 0x2::coin::create_currency<TESTTOOLS3>(arg0, 9, b"TT3", b"TestTools3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTOOLS3>(&mut v2, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOOLS3>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTTOOLS3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

