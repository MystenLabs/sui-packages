module 0x7d58bf2f9cb1ac34d3b738d18fc3a53efb04f41f0d610c93d806d811ae3a0d62::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: vector<0x2::coin::Coin<PEPE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<PEPE>>(&mut arg1);
        0x2::pay::join_vec<PEPE>(&mut v0, arg1);
        0x2::coin::burn<PEPE>(arg0, 0x2::coin::split<PEPE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<PEPE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<PEPE>(v0);
        };
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<PEPE>(arg0, 7, b"PEPE", b"Pepe", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<PEPE>(&mut v4, 6900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<PEPE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

