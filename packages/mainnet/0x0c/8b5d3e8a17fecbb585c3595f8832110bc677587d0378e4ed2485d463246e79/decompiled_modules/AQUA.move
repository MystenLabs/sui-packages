module 0xc8b5d3e8a17fecbb585c3595f8832110bc677587d0378e4ed2485d463246e79::AQUA {
    struct AQUA has drop {
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

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/cp7ko2r.png"));
        let (v1, v2) = 0x2::coin::create_currency<AQUA>(arg0, 9, b"AQUA", b"AquaYama", b"Your yama drinking some Aqua is here", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<AQUA>>(0x2::coin::mint<AQUA>(&mut v3, 100000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"AQUA",
            name    : b"AquaYama",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://aquayama.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/aquayama")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

