module 0x2d0ccc013d00105e9a065fe0d2ea54a7529694fc73dd40f07cb8c55326c1e754::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HORNY>, arg1: vector<0x2::coin::Coin<HORNY>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HORNY>>(&mut arg1);
        0x2::pay::join_vec<HORNY>(&mut v0, arg1);
        0x2::coin::burn<HORNY>(arg0, 0x2::coin::split<HORNY>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HORNY>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HORNY>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HORNY>(v0);
        };
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<HORNY>(arg0, 8, b"Horny", b"Horny", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<HORNY>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HORNY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HORNY>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HORNY>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HORNY>>(arg0);
    }

    // decompiled from Move bytecode v6
}

