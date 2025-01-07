module 0x490d2036d16951209afa6cae18e93c39f9ba34d8eef8a978ddf3c43f5c9ab6bd::fixwalletspls {
    struct FIXWALLETSPLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIXWALLETSPLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIXWALLETSPLS>(arg0, 9, b"FIXWALLETSPLS", b"Please fix wallets i cannot take it anymore", b"fix wallets pls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvZ9_Rl6j8noKJWJ5dlXbNqrZ4uMYLkgZD8g&s"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIXWALLETSPLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FIXWALLETSPLS>>(0x2::coin::mint<FIXWALLETSPLS>(&mut v2, 100000000000000000, arg1), @0x8f7472504821715512572f29b521d10af0b11ecd27f887f6c7a55ad020c184e7);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIXWALLETSPLS>>(v2, @0x8f7472504821715512572f29b521d10af0b11ecd27f887f6c7a55ad020c184e7);
    }

    // decompiled from Move bytecode v6
}

