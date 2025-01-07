module 0xe7eb68f1e0b32e08ca32c06c58bb50aca8a2dc3f64bc30fea3871bada7042165::hodlmetight {
    struct HODLMETIGHT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HODLMETIGHT>, arg1: vector<0x2::coin::Coin<HODLMETIGHT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HODLMETIGHT>>(&mut arg1);
        0x2::pay::join_vec<HODLMETIGHT>(&mut v0, arg1);
        0x2::coin::burn<HODLMETIGHT>(arg0, 0x2::coin::split<HODLMETIGHT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HODLMETIGHT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HODLMETIGHT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HODLMETIGHT>(v0);
        };
    }

    fun init(arg0: HODLMETIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<HODLMETIGHT>(arg0, 9, b"HDMT", b"HODLMETIGHT", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<HODLMETIGHT>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLMETIGHT>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLMETIGHT>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HODLMETIGHT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HODLMETIGHT>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HODLMETIGHT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HODLMETIGHT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

