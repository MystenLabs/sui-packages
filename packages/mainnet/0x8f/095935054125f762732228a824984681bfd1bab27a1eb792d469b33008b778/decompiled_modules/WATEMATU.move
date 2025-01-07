module 0x8f095935054125f762732228a824984681bfd1bab27a1eb792d469b33008b778::WATEMATU {
    struct WATEMATU has drop {
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

    fun init(arg0: WATEMATU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/lMxDXHX.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<WATEMATU>(arg0, 9, b"WATEMATU", b"MATU WATER CAT", b"MATU WATER CAT", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WATEMATU>>(0x2::coin::mint<WATEMATU>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATEMATU>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WATEMATU",
            name    : b"MATU WATER CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://catter.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/CatterToken")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATEMATU>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

