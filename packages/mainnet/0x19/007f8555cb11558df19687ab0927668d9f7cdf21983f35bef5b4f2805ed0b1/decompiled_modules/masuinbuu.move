module 0x19007f8555cb11558df19687ab0927668d9f7cdf21983f35bef5b4f2805ed0b1::masuinbuu {
    struct MASUINBUU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MASUINBUU>, arg1: vector<0x2::coin::Coin<MASUINBUU>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MASUINBUU>>(&mut arg1);
        0x2::pay::join_vec<MASUINBUU>(&mut v0, arg1);
        0x2::coin::burn<MASUINBUU>(arg0, 0x2::coin::split<MASUINBUU>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MASUINBUU>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MASUINBUU>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MASUINBUU>(v0);
        };
    }

    fun init(arg0: MASUINBUU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmPBsPsRr3YGMXWoAfXxbHspYCqUU5Qae9GiRAtY9Q6WxJ"));
        let (v2, v3) = 0x2::coin::create_currency<MASUINBUU>(arg0, 8, b"Mbuu", b"MasuinBuu", b"suiiii", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASUINBUU>>(v3);
        0x2::coin::mint_and_transfer<MASUINBUU>(&mut v4, 15000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASUINBUU>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MASUINBUU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MASUINBUU>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MASUINBUU>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MASUINBUU>>(arg0);
    }

    // decompiled from Move bytecode v6
}

