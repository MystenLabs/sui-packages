module 0xdc55c03040c14bdb38aded0fbb71b9ac6fd2083eb93a11b853c704d3ee2d27af::TALLY {
    struct TALLY has drop {
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

    fun init(arg0: TALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/pnD1WlW.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<TALLY>(arg0, 9, b"TALLY", b"WALLY CAT", b"WALLY is literally a WALLY cat", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TALLY>>(0x2::coin::mint<TALLY>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TALLY>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"TALLY",
            name    : b"WALLY CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://WALLYCAT.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/WALLYCAT")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALLY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

