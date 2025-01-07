module 0xdc00a7346f834c72ca5f8f982bbef67ae64f6fa859732d74c285b1904f138bfc::suirocket {
    struct SUIROCKET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIROCKET>, arg1: vector<0x2::coin::Coin<SUIROCKET>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIROCKET>>(&mut arg1);
        0x2::pay::join_vec<SUIROCKET>(&mut v0, arg1);
        0x2::coin::burn<SUIROCKET>(arg0, 0x2::coin::split<SUIROCKET>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIROCKET>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIROCKET>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIROCKET>(v0);
        };
    }

    fun init(arg0: SUIROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUIROCKET>(arg0, 6, b"ROCKET", b"SuiRocket", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUIROCKET>(&mut v4, 250000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCKET>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCKET>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIROCKET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIROCKET>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIROCKET>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIROCKET>>(arg0);
    }

    // decompiled from Move bytecode v6
}

