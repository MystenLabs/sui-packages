module 0x3389a954e2771655dd40e7715eb266d1f876cb9501ce4da123d8ff2c09579743::traderscoin {
    struct TRADERSCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRADERSCOIN>, arg1: vector<0x2::coin::Coin<TRADERSCOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TRADERSCOIN>>(&mut arg1);
        0x2::pay::join_vec<TRADERSCOIN>(&mut v0, arg1);
        0x2::coin::burn<TRADERSCOIN>(arg0, 0x2::coin::split<TRADERSCOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TRADERSCOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TRADERSCOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TRADERSCOIN>(v0);
        };
    }

    fun init(arg0: TRADERSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<TRADERSCOIN>(arg0, 9, b"TC", b"TRADERSCOIN", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<TRADERSCOIN>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADERSCOIN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRADERSCOIN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRADERSCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TRADERSCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TRADERSCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRADERSCOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

