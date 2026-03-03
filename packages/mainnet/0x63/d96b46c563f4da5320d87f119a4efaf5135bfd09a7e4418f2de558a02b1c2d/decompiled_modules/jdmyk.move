module 0x63d96b46c563f4da5320d87f119a4efaf5135bfd09a7e4418f2de558a02b1c2d::jdmyk {
    struct JDMYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDMYK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/AUwTh_hR1y6jhhvYDVSLZPLgcBD7eZcI1ka2Fn4Kxf4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/AUwTh_hR1y6jhhvYDVSLZPLgcBD7eZcI1ka2Fn4Kxf4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JDMYK>(arg0, 9, trim_right(b"JDMYK"), trim_right(b"JDMYK  "), trim_right(b"JD-MYD, also known as JD stablecoin, is a stablecoin based on a public blockchain. Its reserves consist of highly liquid and trustworthy assets."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JDMYK>>(0x2::coin::mint<JDMYK>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDMYK>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JDMYK>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDMYK>>(v4);
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

