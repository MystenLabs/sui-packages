module 0x238ecdbc523cfc5de4f64f8384c2b62395c28a530b933f1e87dfbd92696612ea::RAIN {
    struct RAIN has drop {
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

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/5BgEG0Y.png"));
        let (v1, v2) = 0x2::coin::create_currency<RAIN>(arg0, 9, b"RAIN", b"Siu Rain", b"Siu es getting a big rain", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<RAIN>>(0x2::coin::mint<RAIN>(&mut v3, 10000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAIN>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"RAIN",
            name    : b"Siu Rain",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://rainsui.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/rainsui")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

