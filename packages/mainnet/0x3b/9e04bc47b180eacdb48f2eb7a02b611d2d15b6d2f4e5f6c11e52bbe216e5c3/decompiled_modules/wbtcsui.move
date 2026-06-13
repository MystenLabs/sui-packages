module 0x3b9e04bc47b180eacdb48f2eb7a02b611d2d15b6d2f4e5f6c11e52bbe216e5c3::wbtcsui {
    struct WBTCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/vpGpnA3yuJzGBvcKwBHgREG_fwYvrOOMRlBo8ahmJg0";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/vpGpnA3yuJzGBvcKwBHgREG_fwYvrOOMRlBo8ahmJg0"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<WBTCSUI>(arg0, 9, trim_right(b"wBTCsui"), trim_right(b"wbtcsui"), trim_right(b"hh"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (200000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WBTCSUI>>(0x2::coin::mint<WBTCSUI>(&mut v5, 200000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTCSUI>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WBTCSUI>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBTCSUI>>(v4);
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

