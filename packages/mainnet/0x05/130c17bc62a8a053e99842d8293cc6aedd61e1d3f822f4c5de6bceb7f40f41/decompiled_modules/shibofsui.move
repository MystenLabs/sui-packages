module 0x5130c17bc62a8a053e99842d8293cc6aedd61e1d3f822f4c5de6bceb7f40f41::shibofsui {
    struct SHIBOFSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBOFSUI>, arg1: vector<0x2::coin::Coin<SHIBOFSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SHIBOFSUI>>(&mut arg1);
        0x2::pay::join_vec<SHIBOFSUI>(&mut v0, arg1);
        0x2::coin::burn<SHIBOFSUI>(arg0, 0x2::coin::split<SHIBOFSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SHIBOFSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SHIBOFSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SHIBOFSUI>(v0);
        };
    }

    fun init(arg0: SHIBOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SHIBOFSUI>(arg0, 8, b"SHIB", b"ShibOfSui", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SHIBOFSUI>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBOFSUI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBOFSUI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBOFSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBOFSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SHIBOFSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHIBOFSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

