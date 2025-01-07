module 0xe7d455b8f1908b6160e6f08e6ce0780425cf5fa4ab232524c029a3769804d00::test_token_3am {
    struct TEST_TOKEN_3AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_3AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_3AM>(arg0, 10, b"TEST_TOKEN_3AM", b"testtoken3am", b"testtoken3am description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8iB11vE7qmEdgHxD7Hnm4_gi6R4KJ9B8nzs_su6iaGg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN_3AM>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_3AM>>(v2, @0x86e3289eada655152a41cb1045c0b26b3ed981eee9529fcdebda70f2c511595a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_3AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

