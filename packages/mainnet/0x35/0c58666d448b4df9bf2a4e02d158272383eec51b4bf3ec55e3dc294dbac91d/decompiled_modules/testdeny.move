module 0x350c58666d448b4df9bf2a4e02d158272383eec51b4bf3ec55e3dc294dbac91d::testdeny {
    struct TESTDENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTDENY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 759 || 0x2::tx_context::epoch(arg1) == 760, 1);
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TESTDENY>(arg0, 9, b"TSTD", b"TestDeny", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), true, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TESTDENY>(&mut v3, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTDENY>>(v3, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTDENY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TESTDENY>>(v1, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
    }

    // decompiled from Move bytecode v6
}

