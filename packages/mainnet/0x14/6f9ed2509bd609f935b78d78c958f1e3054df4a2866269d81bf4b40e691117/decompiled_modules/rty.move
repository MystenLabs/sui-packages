module 0x146f9ed2509bd609f935b78d78c958f1e3054df4a2866269d81bf4b40e691117::rty {
    struct RTY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RTY>, arg1: vector<0x2::coin::Coin<RTY>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<RTY>>(&mut arg1);
        0x2::pay::join_vec<RTY>(&mut v0, arg1);
        0x2::coin::burn<RTY>(arg0, 0x2::coin::split<RTY>(&mut v0, arg2, arg3));
        if (0x2::coin::value<RTY>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<RTY>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<RTY>(v0);
        };
    }

    fun init(arg0: RTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<RTY>(arg0, 9, b"rty", b"RTY", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<RTY>(&mut v4, 2000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTY>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTY>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RTY>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<RTY>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RTY>>(arg0);
    }

    // decompiled from Move bytecode v6
}

