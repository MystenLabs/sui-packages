module 0x86b4a77d4f19a703bf23e9a68743684ed69a1dfb43412cbee55f0308ed986657::ac_b_test_token_4am {
    struct AC_B_TEST_TOKEN_4AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_TEST_TOKEN_4AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_TEST_TOKEN_4AM>(arg0, 6, b"ac_b_TEST_TOKEN_4am", b"TicketFortesttoken4am", b"Pre sale ticket of bonding curve pool for the following memecoin: testtoken4am", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8iB11vE7qmEdgHxD7Hnm4_gi6R4KJ9B8nzs_su6iaGg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_TEST_TOKEN_4AM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_TEST_TOKEN_4AM>>(v2, @0x86e3289eada655152a41cb1045c0b26b3ed981eee9529fcdebda70f2c511595a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_TEST_TOKEN_4AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

