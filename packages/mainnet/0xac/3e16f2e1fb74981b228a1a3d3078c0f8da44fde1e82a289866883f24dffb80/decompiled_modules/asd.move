module 0xac3e16f2e1fb74981b228a1a3d3078c0f8da44fde1e82a289866883f24dffb80::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: vector<0x2::coin::Coin<ASD>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ASD>>(&mut arg1);
        0x2::pay::join_vec<ASD>(&mut v0, arg1);
        0x2::coin::burn<ASD>(arg0, 0x2::coin::split<ASD>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ASD>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ASD>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ASD>(v0);
        };
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<ASD>(arg0, 9, b"asd", b"ASD", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<ASD>(&mut v4, 2000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASD>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ASD>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASD>>(arg0);
    }

    // decompiled from Move bytecode v6
}

