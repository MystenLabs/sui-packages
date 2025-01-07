module 0xf87d18b78f524f6b2160a042e29b6fab01a4b50cd7d8a3b953b448e811322278::WALLY {
    struct WALLY has drop {
        dummy_field: bool,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        name: vector<u8>,
        image: 0x2::url::Url,
        website: 0x2::url::Url,
        twitter: 0x2::url::Url,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/pnD1WlW.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<WALLY>(arg0, 9, b"WALLY", b"WALLY CAT", b"WALLY is literally a WALLY cat", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WALLY>>(0x2::coin::mint<WALLY>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WALLY",
            name    : b"WALLY CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://WALLYCAT.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/WALLYCAT")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

