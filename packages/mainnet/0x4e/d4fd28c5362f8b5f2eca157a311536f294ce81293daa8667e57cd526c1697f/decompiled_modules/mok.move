module 0x4ed4fd28c5362f8b5f2eca157a311536f294ce81293daa8667e57cd526c1697f::mok {
    struct MOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOK>, arg1: vector<0x2::coin::Coin<MOK>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MOK>>(&mut arg1);
        0x2::pay::join_vec<MOK>(&mut v0, arg1);
        0x2::coin::burn<MOK>(arg0, 0x2::coin::split<MOK>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MOK>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOK>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MOK>(v0);
        };
    }

    fun init(arg0: MOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmfXsdKxbvAdKTqbrpDCqSFhPwTbaP9dnNnGVTbBcqPbAu"));
        let (v2, v3) = 0x2::coin::create_currency<MOK>(arg0, 6, b"MOK", b"MOK", b"monkey", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOK>>(v3);
        0x2::coin::mint_and_transfer<MOK>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOK>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOK>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

