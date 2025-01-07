module 0x188d3601c191efa6b4e5aad5b8b1b5e57021006c090e9138006e8aebb273b8ed::multi {
    struct MULTI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MULTI>, arg1: vector<0x2::coin::Coin<MULTI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MULTI>>(&mut arg1);
        0x2::pay::join_vec<MULTI>(&mut v0, arg1);
        0x2::coin::burn<MULTI>(arg0, 0x2::coin::split<MULTI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MULTI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MULTI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MULTI>(v0);
        };
    }

    fun init(arg0: MULTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MULTI>(arg0, 9, b"MULTI", b"MULTI", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MULTI>(&mut v4, 100000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULTI>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MULTI>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MULTI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MULTI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MULTI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MULTI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

