module 0x1e3a69be379a63c3a38a2b016afc051758bf740a967c140b784ce86ea9335849::jdmyr {
    struct JDMYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDMYR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/AUwTh_hR1y6jhhvYDVSLZPLgcBD7eZcI1ka2Fn4Kxf4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/AUwTh_hR1y6jhhvYDVSLZPLgcBD7eZcI1ka2Fn4Kxf4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JDMYR>(arg0, 9, trim_right(b"JDMYR"), trim_right(b"JDMYR  "), trim_right(b"JD Stablecoin, also known as JD-MYR, is a stablecoin based on a public blockchain. Its reserves consist of highly liquid and trustworthy assets."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JDMYR>>(0x2::coin::mint<JDMYR>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDMYR>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JDMYR>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDMYR>>(v4);
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

