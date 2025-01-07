module 0xe605993146a12f00b1f93368682b07f930e8b5ae3ae3c2f7f68374770037ef3a::wolfpack {
    struct WOLFPACK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOLFPACK>, arg1: vector<0x2::coin::Coin<WOLFPACK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<WOLFPACK>>(&mut arg1);
        0x2::pay::join_vec<WOLFPACK>(&mut v0, arg1);
        0x2::coin::burn<WOLFPACK>(arg0, 0x2::coin::split<WOLFPACK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<WOLFPACK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WOLFPACK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<WOLFPACK>(v0);
        };
    }

    fun init(arg0: WOLFPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<WOLFPACK>(arg0, 9, b"Party", b"Wolfpack", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<WOLFPACK>(&mut v4, 4200000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFPACK>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFPACK>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOLFPACK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOLFPACK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<WOLFPACK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WOLFPACK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

