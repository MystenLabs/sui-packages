module 0xa7e68498d964c346a7521876a0545d96a56bd901b8a5250e6effe5c994eb73fb::CATTER {
    struct CATTER has drop {
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

    fun init(arg0: CATTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/lMxDXHX.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<CATTER>(arg0, 9, b"WATTER", b"WATER CAT", b"WATTER CAT is literally a wet cat", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<CATTER>>(0x2::coin::mint<CATTER>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATTER>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WATTER",
            name    : b"WATER CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://catter.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/CatterToken")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTER>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

