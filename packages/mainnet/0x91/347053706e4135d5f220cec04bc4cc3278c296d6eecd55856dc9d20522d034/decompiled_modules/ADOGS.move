module 0x91347053706e4135d5f220cec04bc4cc3278c296d6eecd55856dc9d20522d034::ADOGS {
    struct ADOGS has drop {
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

    fun init(arg0: ADOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/Ed2JZgc.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<ADOGS>(arg0, 9, b"ADOGS", b"ALPHA DOGS ON SUI", b"Alpha Dogs on sui to build a secret crew on SUI", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<ADOGS>>(0x2::coin::mint<ADOGS>(&mut v3, 10000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADOGS>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"ADOGS",
            name    : b"ALPHA DOGS ON SUI",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://alphaDogsSui.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/alphaDogsSui")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOGS>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

