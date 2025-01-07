module 0x5d6e4976fdd02fef67a6cc866f73128cbdb18be32fd94499e26a7ad9542c2d82::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPERMAN>, arg1: vector<0x2::coin::Coin<SUIPERMAN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUIPERMAN>>(&mut arg1);
        0x2::pay::join_vec<SUIPERMAN>(&mut v0, arg1);
        0x2::coin::burn<SUIPERMAN>(arg0, 0x2::coin::split<SUIPERMAN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUIPERMAN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUIPERMAN>(v0);
        };
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmcGJvTgsYrTbuK2aHWHbQaUr9EY1SUXrggMtxWKPjBnaJ"));
        let (v2, v3) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 9, b"SPM", b"SUIperman", b"Introducing SUIperman, the superhero of the digital currency world, built on the revolutionary SUI blockchain! ", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v3);
        0x2::coin::mint_and_transfer<SUIPERMAN>(&mut v4, 1000000001000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPERMAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPERMAN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUIPERMAN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPERMAN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

