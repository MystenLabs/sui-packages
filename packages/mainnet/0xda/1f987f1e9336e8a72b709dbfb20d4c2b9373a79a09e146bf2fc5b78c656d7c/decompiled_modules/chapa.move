module 0xda1f987f1e9336e8a72b709dbfb20d4c2b9373a79a09e146bf2fc5b78c656d7c::chapa {
    struct CHAPA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHAPA>, arg1: vector<0x2::coin::Coin<CHAPA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<CHAPA>>(&mut arg1);
        0x2::pay::join_vec<CHAPA>(&mut v0, arg1);
        0x2::coin::burn<CHAPA>(arg0, 0x2::coin::split<CHAPA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<CHAPA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHAPA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<CHAPA>(v0);
        };
    }

    fun init(arg0: CHAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<CHAPA>(arg0, 7, b"CHAPA", b"CHAPA", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<CHAPA>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPA>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAPA>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHAPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAPA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CHAPA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHAPA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

