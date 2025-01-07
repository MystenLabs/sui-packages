module 0xea394fadd1fe4c4c51480b5b8c30dec1c8df52b8a71fb04987e6ab200230738e::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONK>, arg1: vector<0x2::coin::Coin<BONK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BONK>>(&mut arg1);
        0x2::pay::join_vec<BONK>(&mut v0, arg1);
        0x2::coin::burn<BONK>(arg0, 0x2::coin::split<BONK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BONK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BONK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BONK>(v0);
        };
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BONK>(arg0, 9, b"BONK", b"Bonk", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BONK>(&mut v4, 100000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BONK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

