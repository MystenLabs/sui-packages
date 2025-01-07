module 0xd47a726891c02863014c0847092ede4a1dc9491795e4253027665b146d24f903::memela {
    struct MEMELA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMELA>, arg1: vector<0x2::coin::Coin<MEMELA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MEMELA>>(&mut arg1);
        0x2::pay::join_vec<MEMELA>(&mut v0, arg1);
        0x2::coin::burn<MEMELA>(arg0, 0x2::coin::split<MEMELA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MEMELA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEMELA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MEMELA>(v0);
        };
    }

    fun init(arg0: MEMELA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MEMELA>(arg0, 9, b"MLA", b"Memela", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MEMELA>(&mut v4, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMELA>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMELA>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMELA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMELA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MEMELA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMELA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

