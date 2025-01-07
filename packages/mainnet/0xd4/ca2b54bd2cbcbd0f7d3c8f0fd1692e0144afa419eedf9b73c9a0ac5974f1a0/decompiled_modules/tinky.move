module 0xd4ca2b54bd2cbcbd0f7d3c8f0fd1692e0144afa419eedf9b73c9a0ac5974f1a0::tinky {
    struct TINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINKY>(arg0, 9, b"TINKY", b"Tinker", b"\"Tinker\" (Ticker: TINKY) is a playful, inventive token on the Sui blockchain, representing curiosity and growth. Perfect for those seeking fun and dynamic opportunities in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1608734556907094019/nZyBEj9j.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TINKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

