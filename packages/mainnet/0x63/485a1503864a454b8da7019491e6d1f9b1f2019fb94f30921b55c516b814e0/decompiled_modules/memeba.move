module 0x63485a1503864a454b8da7019491e6d1f9b1f2019fb94f30921b55c516b814e0::memeba {
    struct MEMEBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMEBA>, arg1: vector<0x2::coin::Coin<MEMEBA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MEMEBA>>(&mut arg1);
        0x2::pay::join_vec<MEMEBA>(&mut v0, arg1);
        0x2::coin::burn<MEMEBA>(arg0, 0x2::coin::split<MEMEBA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MEMEBA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEMEBA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MEMEBA>(v0);
        };
    }

    fun init(arg0: MEMEBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MEMEBA>(arg0, 9, b"MMB", b"Memeba", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MEMEBA>(&mut v4, 1000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEBA>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEBA>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMEBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMEBA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MEMEBA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMEBA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

