module 0xe68facb7a786c545920bf4bbf39416ce5d9ae0e4fb65638a5f2fdf7ff896bd6a::alphawolfpack {
    struct ALPHAWOLFPACK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ALPHAWOLFPACK>, arg1: vector<0x2::coin::Coin<ALPHAWOLFPACK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ALPHAWOLFPACK>>(&mut arg1);
        0x2::pay::join_vec<ALPHAWOLFPACK>(&mut v0, arg1);
        0x2::coin::burn<ALPHAWOLFPACK>(arg0, 0x2::coin::split<ALPHAWOLFPACK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ALPHAWOLFPACK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ALPHAWOLFPACK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ALPHAWOLFPACK>(v0);
        };
    }

    fun init(arg0: ALPHAWOLFPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<ALPHAWOLFPACK>(arg0, 9, b"Party", b"AlphaWolfpack", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<ALPHAWOLFPACK>(&mut v4, 420000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHAWOLFPACK>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHAWOLFPACK>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALPHAWOLFPACK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ALPHAWOLFPACK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ALPHAWOLFPACK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALPHAWOLFPACK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

