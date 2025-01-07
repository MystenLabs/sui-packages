module 0x1fe6b27021f96f0f288786056bfdd13db73c6ff9104f6e4e4656039e120259ba::CUWAT {
    struct CUWAT has drop {
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

    fun init(arg0: CUWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/mgdT04g.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<CUWAT>(arg0, 9, b"CUWAT", b"CAT UNDER WATER ", b"Best cat under the water", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUWAT>>(0x2::coin::mint<CUWAT>(&mut v3, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUWAT>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"CUWAT",
            name    : b"CAT UNDER WATER ",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://CUWAT.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/CUWAT")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUWAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

