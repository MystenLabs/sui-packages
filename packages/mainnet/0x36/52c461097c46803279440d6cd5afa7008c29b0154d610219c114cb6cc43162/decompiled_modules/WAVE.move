module 0x3652c461097c46803279440d6cd5afa7008c29b0154d610219c114cb6cc43162::WAVE {
    struct WAVE has drop {
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

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/BLAE2K8.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"The siu wave", b"We didnt expect this massive wave", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WAVE>>(0x2::coin::mint<WAVE>(&mut v3, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"WAVE",
            name    : b"The siu wave",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://WAVE.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/WAVE")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

