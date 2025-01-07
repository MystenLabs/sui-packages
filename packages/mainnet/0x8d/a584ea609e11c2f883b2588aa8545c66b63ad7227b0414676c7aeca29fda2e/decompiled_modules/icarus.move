module 0x8da584ea609e11c2f883b2588aa8545c66b63ad7227b0414676c7aeca29fda2e::icarus {
    struct ICARUS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ICARUS>, arg1: vector<0x2::coin::Coin<ICARUS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ICARUS>>(&mut arg1);
        0x2::pay::join_vec<ICARUS>(&mut v0, arg1);
        0x2::coin::burn<ICARUS>(arg0, 0x2::coin::split<ICARUS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<ICARUS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ICARUS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<ICARUS>(v0);
        };
    }

    fun init(arg0: ICARUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<ICARUS>(arg0, 9, b"ICA", b"ICARUS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<ICARUS>(&mut v4, 10000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICARUS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICARUS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ICARUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ICARUS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ICARUS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ICARUS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

