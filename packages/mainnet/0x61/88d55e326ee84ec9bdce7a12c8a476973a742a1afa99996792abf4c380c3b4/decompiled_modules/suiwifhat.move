module 0x6188d55e326ee84ec9bdce7a12c8a476973a742a1afa99996792abf4c380c3b4::suiwifhat {
    struct SUIWIFHAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIWIFHAT>, arg1: vector<0x2::coin::Coin<SUIWIFHAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIWIFHAT>>(&mut arg1);
        0x2::pay::join_vec<SUIWIFHAT>(&mut v0, arg1);
        0x2::coin::burn<SUIWIFHAT>(arg0, 0x2::coin::split<SUIWIFHAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIWIFHAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIWIFHAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIWIFHAT>(v0);
        };
    }

    fun init(arg0: SUIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUIWIFHAT>(arg0, 4, b"SIF", b"SUIWIFHAT", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIWIFHAT>(&mut v4, 10000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFHAT>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIFHAT>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIWIFHAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIWIFHAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIWIFHAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIWIFHAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

