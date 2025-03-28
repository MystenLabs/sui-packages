module 0x430be26bea1783714753d9c79ca6a2edaba6fe653d1febfec089c18ee3225e91::topcoinmarket {
    struct TOPCOINMARKET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOPCOINMARKET>, arg1: vector<0x2::coin::Coin<TOPCOINMARKET>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<TOPCOINMARKET>>(&mut arg1);
        0x2::pay::join_vec<TOPCOINMARKET>(&mut v0, arg1);
        0x2::coin::burn<TOPCOINMARKET>(arg0, 0x2::coin::split<TOPCOINMARKET>(&mut v0, arg2, arg3));
        if (0x2::coin::value<TOPCOINMARKET>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TOPCOINMARKET>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TOPCOINMARKET>(v0);
        };
    }

    fun init(arg0: TOPCOINMARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<TOPCOINMARKET>(arg0, 7, b"TCM", b"TOPCOINMARKET", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<TOPCOINMARKET>(&mut v4, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPCOINMARKET>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPCOINMARKET>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOPCOINMARKET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOPCOINMARKET>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TOPCOINMARKET>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOPCOINMARKET>>(arg0);
    }

    // decompiled from Move bytecode v6
}

