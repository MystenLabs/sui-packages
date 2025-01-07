module 0xc3e6da9cbc506b3028c648ea971f2c99dbf19489c5b8c4e95646f3d3dd476b2f::world {
    struct WORLD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WORLD>, arg1: vector<0x2::coin::Coin<WORLD>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<WORLD>>(&mut arg1);
        0x2::pay::join_vec<WORLD>(&mut v0, arg1);
        0x2::coin::burn<WORLD>(arg0, 0x2::coin::split<WORLD>(&mut v0, arg2, arg3));
        if (0x2::coin::value<WORLD>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WORLD>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<WORLD>(v0);
        };
    }

    fun init(arg0: WORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<WORLD>(arg0, 6, b"WORLD", b"WORLD", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<WORLD>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLD>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORLD>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WORLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WORLD>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<WORLD>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WORLD>>(arg0);
    }

    // decompiled from Move bytecode v6
}

