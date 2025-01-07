module 0x3296d18ba9c8c619c35c9e1cb17e487559fe1b79bfa73a4a70960224e3b85a13::spglabs {
    struct SPGLABS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPGLABS>, arg1: vector<0x2::coin::Coin<SPGLABS>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SPGLABS>>(&mut arg1);
        0x2::pay::join_vec<SPGLABS>(&mut v0, arg1);
        0x2::coin::burn<SPGLABS>(arg0, 0x2::coin::split<SPGLABS>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SPGLABS>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SPGLABS>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SPGLABS>(v0);
        };
    }

    fun init(arg0: SPGLABS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SPGLABS>(arg0, 8, b"SPG", b"SPGLABS", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SPGLABS>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPGLABS>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPGLABS>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPGLABS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPGLABS>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SPGLABS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPGLABS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

