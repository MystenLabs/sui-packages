module 0xb96e5be5de4ea7bd58987a3a4172e83d3d281a64bd617c610bb1749091c414b6::suikishu {
    struct SUIKISHU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKISHU>, arg1: vector<0x2::coin::Coin<SUIKISHU>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIKISHU>>(&mut arg1);
        0x2::pay::join_vec<SUIKISHU>(&mut v0, arg1);
        0x2::coin::burn<SUIKISHU>(arg0, 0x2::coin::split<SUIKISHU>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIKISHU>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIKISHU>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIKISHU>(v0);
        };
    }

    fun init(arg0: SUIKISHU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUIKISHU>(arg0, 2, b"SKISHU", b"SUIKISHU", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIKISHU>(&mut v4, 4100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKISHU>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKISHU>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKISHU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIKISHU>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIKISHU>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIKISHU>>(arg0);
    }

    // decompiled from Move bytecode v6
}

