module 0x629c4208a3242aafb7acfd30043dd130deb3a937e337b613e611ffca96fdaec0::a {
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
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<A>(arg0, 9, b"a", b"A", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<A>(&mut v4, 2000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<A>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<A>>(arg0);
    }

    // decompiled from Move bytecode v6
}

