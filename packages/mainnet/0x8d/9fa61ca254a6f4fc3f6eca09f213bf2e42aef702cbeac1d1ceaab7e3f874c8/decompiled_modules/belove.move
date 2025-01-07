module 0x8d9fa61ca254a6f4fc3f6eca09f213bf2e42aef702cbeac1d1ceaab7e3f874c8::belove {
    struct BELOVE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BELOVE>, arg1: vector<0x2::coin::Coin<BELOVE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BELOVE>>(&mut arg1);
        0x2::pay::join_vec<BELOVE>(&mut v0, arg1);
        0x2::coin::burn<BELOVE>(arg0, 0x2::coin::split<BELOVE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BELOVE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BELOVE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BELOVE>(v0);
        };
    }

    fun init(arg0: BELOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BELOVE>(arg0, 7, b"bel", b"belove", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BELOVE>(&mut v4, 1000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELOVE>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELOVE>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BELOVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BELOVE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BELOVE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BELOVE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

