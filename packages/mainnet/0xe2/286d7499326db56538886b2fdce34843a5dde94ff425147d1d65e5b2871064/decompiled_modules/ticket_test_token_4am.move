module 0xe2286d7499326db56538886b2fdce34843a5dde94ff425147d1d65e5b2871064::ticket_test_token_4am {
    struct TICKET_TEST_TOKEN_4AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKET_TEST_TOKEN_4AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKET_TEST_TOKEN_4AM>(arg0, 6, b"ticket_TEST_TOKEN_4am", b"TicketFortesttoken4am", b"Pre sale ticket of bonding curve pool for the following memecoin: testtoken4am", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKET_TEST_TOKEN_4AM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKET_TEST_TOKEN_4AM>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKET_TEST_TOKEN_4AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

