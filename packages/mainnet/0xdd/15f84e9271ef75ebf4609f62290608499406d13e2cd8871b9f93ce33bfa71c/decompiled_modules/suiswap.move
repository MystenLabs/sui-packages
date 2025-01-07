module 0xdd15f84e9271ef75ebf4609f62290608499406d13e2cd8871b9f93ce33bfa71c::suiswap {
    struct SUISWAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: vector<0x2::coin::Coin<SUISWAP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUISWAP>>(&mut arg1);
        0x2::pay::join_vec<SUISWAP>(&mut v0, arg1);
        0x2::coin::burn<SUISWAP>(arg0, 0x2::coin::split<SUISWAP>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUISWAP>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISWAP>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUISWAP>(v0);
        };
    }

    fun init(arg0: SUISWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUISWAP>(arg0, 8, b"SSWP", b"SUISWAP", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUISWAP>(&mut v4, 1000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISWAP>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISWAP>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISWAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISWAP>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUISWAP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISWAP>>(arg0);
    }

    // decompiled from Move bytecode v6
}

