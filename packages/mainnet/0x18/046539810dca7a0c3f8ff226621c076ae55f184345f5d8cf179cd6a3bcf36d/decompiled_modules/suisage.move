module 0x18046539810dca7a0c3f8ff226621c076ae55f184345f5d8cf179cd6a3bcf36d::suisage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISAGE>, arg1: vector<0x2::coin::Coin<SUISAGE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUISAGE>>(&mut arg1);
        0x2::pay::join_vec<SUISAGE>(&mut v0, arg1);
        0x2::coin::burn<SUISAGE>(arg0, 0x2::coin::split<SUISAGE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUISAGE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISAGE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUISAGE>(v0);
        };
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWEpMA2f1Myxr7GgnGuEU3nScYkjQ5nB8qFBY6wrrm5qp"));
        let (v2, v3) = 0x2::coin::create_currency<SUISAGE>(arg0, 7, b"Suig", b"Suisage", b"To The moon", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAGE>>(v3);
        0x2::coin::mint_and_transfer<SUISAGE>(&mut v4, 900000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISAGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISAGE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUISAGE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISAGE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

