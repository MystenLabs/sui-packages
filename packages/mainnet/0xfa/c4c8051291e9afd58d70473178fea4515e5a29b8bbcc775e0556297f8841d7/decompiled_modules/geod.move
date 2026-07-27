module 0xfac4c8051291e9afd58d70473178fea4515e5a29b8bbcc775e0556297f8841d7::geod {
    struct GEOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/jWM4aRF0cf3fSo0t2oqn6UHD-yTyScKxDIs4MOdoq3Q";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/jWM4aRF0cf3fSo0t2oqn6UHD-yTyScKxDIs4MOdoq3Q"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<GEOD>(arg0, 9, trim_right(b"GEOD"), trim_right(b"GEOD  "), trim_right(b"GEOD ($GEOD) is the native ERC-20 utility token of GEODNET, a leading DePIN (Decentralized Physical Infrastructure Network) built on the Polygon blockchain, launched in December 2023."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GEOD>>(0x2::coin::mint<GEOD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEOD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GEOD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEOD>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

