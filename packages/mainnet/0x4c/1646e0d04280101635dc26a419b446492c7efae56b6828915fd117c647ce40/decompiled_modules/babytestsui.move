module 0x4c1646e0d04280101635dc26a419b446492c7efae56b6828915fd117c647ce40::babytestsui {
    struct BABYTESTSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABYTESTSUI>, arg1: vector<0x2::coin::Coin<BABYTESTSUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BABYTESTSUI>>(&mut arg1);
        0x2::pay::join_vec<BABYTESTSUI>(&mut v0, arg1);
        0x2::coin::burn<BABYTESTSUI>(arg0, 0x2::coin::split<BABYTESTSUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BABYTESTSUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BABYTESTSUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BABYTESTSUI>(v0);
        };
    }

    fun init(arg0: BABYTESTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BABYTESTSUI>(arg0, 7, b"BTS", b"BABYTESTSUI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BABYTESTSUI>(&mut v4, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTESTSUI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTESTSUI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYTESTSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYTESTSUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BABYTESTSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYTESTSUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

