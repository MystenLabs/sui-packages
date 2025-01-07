module 0xe028b6f52d0344132202582e902008c260b6f934e76d666b047cd49c66feeeb6::MABOY {
    struct MABOY has drop {
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

    fun init(arg0: MABOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/godjuXy.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<MABOY>(arg0, 9, b"MABOY", b"MY BOY ON SUI", b"MY BOY pumping the SUI NET", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<MABOY>>(0x2::coin::mint<MABOY>(&mut v3, 10000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MABOY>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"MABOY",
            name    : b"MY BOY ON SUI",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://myboy.com")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/myboy")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABOY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

