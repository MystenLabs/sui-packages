module 0xcbe983d061fc95ebc5c33c9a08d6791f8e3a8d00f67362565f148ff1a0858e1b::BUBBLE {
    struct BUBBLE has drop {
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

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/lMxDXHX.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<BUBBLE>(arg0, 9, b"BUBBLE", b"SIU BUBBLE", b"SIU BUBBLE IS HERE", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUBBLE>>(0x2::coin::mint<BUBBLE>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLE>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"BUBBLE",
            name    : b"SIU BUBBLE",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://catter.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/CatterToken")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

