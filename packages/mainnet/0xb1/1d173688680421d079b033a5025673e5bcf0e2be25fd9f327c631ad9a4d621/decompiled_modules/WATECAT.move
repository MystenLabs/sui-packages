module 0xb11d173688680421d079b033a5025673e5bcf0e2be25fd9f327c631ad9a4d621::WATECAT {
    struct WATECAT has drop {
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

    fun init(arg0: WATECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/4whUguQ.png"));
        let (v1, v2) = 0x2::coin::create_currency<WATECAT>(arg0, 9, b"WATECAT", b"WATERFALL CAT", b"Its a cat on a waterfall", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WATECAT>>(0x2::coin::mint<WATECAT>(&mut v3, 100000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATECAT>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WATECAT",
            name    : b"WATERFALL CAT",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://watecat.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/watecat")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATECAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

