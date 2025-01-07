module 0xf71ad674b3c2349cc886e4cccadd8fdca666b30d6cb93016cd13edaacc3e6a7d::bat {
    struct BAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAT>, arg1: vector<0x2::coin::Coin<BAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BAT>>(&mut arg1);
        0x2::pay::join_vec<BAT>(&mut v0, arg1);
        0x2::coin::burn<BAT>(arg0, 0x2::coin::split<BAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BAT>(v0);
        };
    }

    fun init(arg0: BAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BAT>(arg0, 9, b"bat", b"bat", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BAT>(&mut v4, 200000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAT>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAT>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

