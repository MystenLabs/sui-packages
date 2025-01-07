module 0x2c777da9813d5eeef07b09f0772ababff269db808023072fc8d753f707770109::PDOGS {
    struct PDOGS has drop {
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

    fun init(arg0: PDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/cg12OlH.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<PDOGS>(arg0, 9, b"PDOGS", b"PUMP DOGS ON SUI", b"Dogs pumping the SUI NET", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<PDOGS>>(0x2::coin::mint<PDOGS>(&mut v3, 10000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDOGS>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"PDOGS",
            name    : b"PUMP DOGS ON SUI",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://pumpdogs.com")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/pumpdogs")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOGS>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

