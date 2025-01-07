module 0x636d5eac0af19830f188a9378a05f11381824a07f3b10532d83209c84c720166::suidos {
    struct SUIDOS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDOS>, arg1: vector<0x2::coin::Coin<SUIDOS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIDOS>>(&mut arg1);
        0x2::pay::join_vec<SUIDOS>(&mut v0, arg1);
        0x2::coin::burn<SUIDOS>(arg0, 0x2::coin::split<SUIDOS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIDOS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIDOS>(v0);
        };
    }

    fun init(arg0: SUIDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUIDOS>(arg0, 6, b"SuiDOS", b"SuiDOS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIDOS>(&mut v4, 110100101010001, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDOS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIDOS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDOS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

