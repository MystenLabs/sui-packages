module 0x96852e5d22d29201b067c46b128c3dd5062f59e0b2d4e276ed2d31225cacdf45::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 1270 || 0x2::tx_context::epoch(arg1) == 1271, 0);
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TEST2>(arg0, 9, b"TST2", b"Test2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.20lab.app/ipfs/QmYLzPiHreZyEon5xg8aFqjHGvGuHm5VjoVbvpHELeBo53"))), true, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TEST2>(&mut v3, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v3, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST2>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TEST2>>(v1, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
    }

    // decompiled from Move bytecode v6
}

