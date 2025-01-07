module 0x2aeddd0db622ae41553ea334c5e458c277688ead72f5c99329692e417a31d12b::windfall {
    struct WINDFALL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WINDFALL>, arg1: vector<0x2::coin::Coin<WINDFALL>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<WINDFALL>>(&mut arg1);
        0x2::pay::join_vec<WINDFALL>(&mut v0, arg1);
        0x2::coin::burn<WINDFALL>(arg0, 0x2::coin::split<WINDFALL>(&mut v0, arg2, arg3));
        if (0x2::coin::value<WINDFALL>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WINDFALL>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<WINDFALL>(v0);
        };
    }

    fun init(arg0: WINDFALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<WINDFALL>(arg0, 9, b"LOTTERY", b"WINDFALL", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<WINDFALL>(&mut v4, 999999999000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDFALL>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINDFALL>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WINDFALL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WINDFALL>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<WINDFALL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WINDFALL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

