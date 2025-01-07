module 0xf70d0a8a96dfce188e3d58d3d9ae6d9470c7b1b02c21690c3acb7b568580c69c::x {
    struct X has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<X>, arg1: vector<0x2::coin::Coin<X>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<X>>(&mut arg1);
        0x2::pay::join_vec<X>(&mut v0, arg1);
        0x2::coin::burn<X>(arg0, 0x2::coin::split<X>(&mut v0, arg2, arg3));
        if (0x2::coin::value<X>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<X>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<X>(v0);
        };
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png"));
        let (v2, v3) = 0x2::coin::create_currency<X>(arg0, 2, b"x", b"x", b"https://cryptologos.cc/logos/bitcoin-btc-logo.png", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v3);
        0x2::coin::mint_and_transfer<X>(&mut v4, 11100, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<X>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<X>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<X>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<X>>(arg0);
    }

    // decompiled from Move bytecode v6
}

