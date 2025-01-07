module 0x6221b545a4c228eff081fdc9b33267a2f10f22c8fcc80089b4b203a081a20139::STATE {
    struct STATE has drop {
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

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/VzuwRHw.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<STATE>(arg0, 9, b"STATE", b"Sui Andrew Tate", b"Andrew Tate walking on sui", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<STATE>>(0x2::coin::mint<STATE>(&mut v3, 10000000 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STATE>>(v2);
        let v4 = TokenMetadata{
            id      : 0x2::object::new(arg1),
            symbol  : b"STATE",
            name    : b"Sui Andrew Tate",
            image   : v0,
            website : 0x2::url::new_unsafe(0x1::ascii::string(b"https://STATE.io")),
            twitter : 0x2::url::new_unsafe(0x1::ascii::string(b"https://twitter.com/SANDREWTATE")),
        };
        0x2::transfer::public_transfer<TokenMetadata>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

