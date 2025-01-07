module 0xe6fe5cea3d43ac1a1b19424c8d706dd03dc6653f091a2fc192b3f7641bd9d15e::bonkii {
    struct BONKII has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONKII>, arg1: vector<0x2::coin::Coin<BONKII>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BONKII>>(&mut arg1);
        0x2::pay::join_vec<BONKII>(&mut v0, arg1);
        0x2::coin::burn<BONKII>(arg0, 0x2::coin::split<BONKII>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BONKII>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BONKII>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BONKII>(v0);
        };
    }

    fun init(arg0: BONKII, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BONKII>(arg0, 9, b"BonkII", b"BonkII", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BONKII>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKII>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKII>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONKII>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONKII>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BONKII>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONKII>>(arg0);
    }

    // decompiled from Move bytecode v6
}

