module 0x5c01804bc6dc5f018996633095165054eafbdd8fc03036dc489e45959e6f7eac::testcet1 {
    struct TESTCET1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCET1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 729 || 0x2::tx_context::epoch(arg1) == 730, 1);
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TESTCET1>(arg0, 9, b"TSTC1", b"TestCet1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), true, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TESTCET1>(&mut v3, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCET1>>(v3, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTCET1>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TESTCET1>>(v1, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
    }

    // decompiled from Move bytecode v6
}

