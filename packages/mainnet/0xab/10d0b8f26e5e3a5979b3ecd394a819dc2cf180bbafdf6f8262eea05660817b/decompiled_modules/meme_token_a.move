module 0xab10d0b8f26e5e3a5979b3ecd394a819dc2cf180bbafdf6f8262eea05660817b::meme_token_a {
    struct MEME_TOKEN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_TOKEN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_TOKEN_A>(arg0, 9, b"VVV", b"VVV", b"hihih", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.coingecko.com/s/coingecko-logo-8903d34ce19ca4be1c81f0db30e924154750d208683fad7ae6f2ce06c76d0a56.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_TOKEN_A>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_TOKEN_A>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_TOKEN_A>>(v1);
    }

    // decompiled from Move bytecode v6
}

