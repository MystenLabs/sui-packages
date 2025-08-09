module 0x84a0cd61eb39185fd73042c7a17d6cef25c21ef701607bfcecb2f8fec457ea43::testtools {
    struct TESTTOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 849 || 0x2::tx_context::epoch(arg1) == 850, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<TESTTOOLS>(arg0, 9, b"TSTST", b"TestTools", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<TESTTOOLS>(&mut v4, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOOLS>>(v4, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTTOOLS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TESTTOOLS>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
    }

    // decompiled from Move bytecode v6
}

