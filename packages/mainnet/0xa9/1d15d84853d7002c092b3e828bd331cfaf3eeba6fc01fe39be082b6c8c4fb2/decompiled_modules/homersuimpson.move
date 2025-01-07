module 0xa91d15d84853d7002c092b3e828bd331cfaf3eeba6fc01fe39be082b6c8c4fb2::homersuimpson {
    struct HOMERSUIMPSON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOMERSUIMPSON>, arg1: vector<0x2::coin::Coin<HOMERSUIMPSON>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HOMERSUIMPSON>>(&mut arg1);
        0x2::pay::join_vec<HOMERSUIMPSON>(&mut v0, arg1);
        0x2::coin::burn<HOMERSUIMPSON>(arg0, 0x2::coin::split<HOMERSUIMPSON>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HOMERSUIMPSON>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HOMERSUIMPSON>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HOMERSUIMPSON>(v0);
        };
    }

    fun init(arg0: HOMERSUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/0/02/Homer_Simpson_2006.png"));
        let (v2, v3) = 0x2::coin::create_currency<HOMERSUIMPSON>(arg0, 8, b"Homer", b"HomerSuimpson", b"Homer", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMERSUIMPSON>>(v3);
        0x2::coin::mint_and_transfer<HOMERSUIMPSON>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMERSUIMPSON>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOMERSUIMPSON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOMERSUIMPSON>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HOMERSUIMPSON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOMERSUIMPSON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

