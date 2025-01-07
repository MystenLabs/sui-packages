module 0x6671890f21c3f3a5ea00af3015db87cc7edf06bd515c17ee210514d0b0924d54::a {
    struct A has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<A>, arg1: vector<0x2::coin::Coin<A>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<A>>(&mut arg1);
        0x2::pay::join_vec<A>(&mut v0, arg1);
        0x2::coin::burn<A>(arg0, 0x2::coin::split<A>(&mut v0, arg2, arg3));
        if (0x2::coin::value<A>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<A>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<A>(v0);
        };
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png"));
        let (v2, v3) = 0x2::coin::create_currency<A>(arg0, 1, b"a", b"a", b"a", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A>>(v3);
        0x2::coin::mint_and_transfer<A>(&mut v4, 100000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<A>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<A>>(arg0);
    }

    // decompiled from Move bytecode v6
}

