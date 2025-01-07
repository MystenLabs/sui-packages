module 0x38432dd1868e3125ea2f1559a00e69041dbf8168a5b0ff073537b672373b0e5b::xrl {
    struct XRL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XRL>, arg1: vector<0x2::coin::Coin<XRL>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<XRL>>(&mut arg1);
        0x2::pay::join_vec<XRL>(&mut v0, arg1);
        0x2::coin::burn<XRL>(arg0, 0x2::coin::split<XRL>(&mut v0, arg2, arg3));
        if (0x2::coin::value<XRL>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<XRL>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<XRL>(v0);
        };
    }

    fun init(arg0: XRL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<XRL>(arg0, 9, b"XRL", b"XRL", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<XRL>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRL>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRL>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XRL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XRL>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XRL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XRL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

