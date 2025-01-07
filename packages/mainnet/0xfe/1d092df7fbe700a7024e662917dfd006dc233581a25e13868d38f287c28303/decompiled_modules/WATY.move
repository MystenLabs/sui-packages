module 0xfe1d092df7fbe700a7024e662917dfd006dc233581a25e13868d38f287c28303::WATY {
    struct WATY has drop {
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

    fun init(arg0: WATY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/lMxDXHX.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<WATY>(arg0, 9, b"WATY", b"WATER CAT", b"WATER CAT is literally a wet cat", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WATY>>(0x2::coin::mint<WATY>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATY>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WATY",
            name    : b"WATER CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://catter.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/CatterToken")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

