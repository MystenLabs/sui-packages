module 0x9fca16de61c7326d63eba3b0786c10bfc9e78c5d2a35e76f40af1d324e0dee32::boboo {
    struct BOBOO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOBOO>, arg1: vector<0x2::coin::Coin<BOBOO>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BOBOO>>(&mut arg1);
        0x2::pay::join_vec<BOBOO>(&mut v0, arg1);
        0x2::coin::burn<BOBOO>(arg0, 0x2::coin::split<BOBOO>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BOBOO>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BOBOO>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BOBOO>(v0);
        };
    }

    fun init(arg0: BOBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRhJUVgnZctGH4oVpfMA5XYLNnitfhs16nn554kKVcdhZ"));
        let (v2, v3) = 0x2::coin::create_currency<BOBOO>(arg0, 9, b"BOBOO", b"Boboo", x"4d65657420426f626f6f2c20746865206d656d652062656172206f6e207468652053756920636861696e21204865e2809973206865726520746f206272696e67206c617567687320616e6420766962657320746f2074686520626c6f636b636861696e20776f726c642e2047657420726561647920666f7220736f6d652062656172792066756e2074696d6573207769746820426f626f6f212057656273697465203a2068747470733a2f2f626f626f6f636f696e2e78797a2074656c656772616d203a2068747470733a2f2f742e6d652f626f626f6f636f696e2078203a2068747470733a2f2f782e636f6d2f626f626f6f636f696e", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOO>>(v3);
        0x2::coin::mint_and_transfer<BOBOO>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOO>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOBOO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOBOO>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BOBOO>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOBOO>>(arg0);
    }

    // decompiled from Move bytecode v6
}

