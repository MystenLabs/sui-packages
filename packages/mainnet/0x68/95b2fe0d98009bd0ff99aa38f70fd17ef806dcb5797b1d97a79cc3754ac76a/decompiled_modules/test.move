module 0x6895b2fe0d98009bd0ff99aa38f70fd17ef806dcb5797b1d97a79cc3754ac76a::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 1271 || 0x2::tx_context::epoch(arg1) == 1272, 0);
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TST", b"Test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000000000, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0xa2a935b425497b6dbc81a5281071a00713f308d902c4900154edd005012dbd2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

