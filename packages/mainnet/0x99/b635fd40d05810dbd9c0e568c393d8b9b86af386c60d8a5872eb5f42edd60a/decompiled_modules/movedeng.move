module 0x99b635fd40d05810dbd9c0e568c393d8b9b86af386c60d8a5872eb5f42edd60a::movedeng {
    struct MOVEDENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVEDENG>, arg1: vector<0x2::coin::Coin<MOVEDENG>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MOVEDENG>>(&mut arg1);
        0x2::pay::join_vec<MOVEDENG>(&mut v0, arg1);
        0x2::coin::burn<MOVEDENG>(arg0, 0x2::coin::split<MOVEDENG>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MOVEDENG>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOVEDENG>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MOVEDENG>(v0);
        };
    }

    fun init(arg0: MOVEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZNz2i99CgogQ473Ym8xj39kupeUKdJcijXq4PuRPvDbm"));
        let (v2, v3) = 0x2::coin::create_currency<MOVEDENG>(arg0, 9, b"MOVE", b"MoveDeng", b"Just a viral lil hippo riding the power of Move language on SUI", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEDENG>>(v3);
        0x2::coin::mint_and_transfer<MOVEDENG>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDENG>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVEDENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOVEDENG>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOVEDENG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOVEDENG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

