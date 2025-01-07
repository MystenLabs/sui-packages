module 0xb74a032863876558330ced06ae570f4c443d8f90eaa8d4858412335e626907ee::ac_b_test_token_3am {
    struct AC_B_TEST_TOKEN_3AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_TEST_TOKEN_3AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_TEST_TOKEN_3AM>(arg0, 6, b"ac_b_TEST_TOKEN_3AM", b"TicketFortesttoken3am", b"Pre sale ticket of bonding curve pool for the following memecoin: testtoken3am", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_TEST_TOKEN_3AM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_TEST_TOKEN_3AM>>(v2, @0x86e3289eada655152a41cb1045c0b26b3ed981eee9529fcdebda70f2c511595a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_TEST_TOKEN_3AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

