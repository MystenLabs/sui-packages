module 0x477bc5abcaa00b1ddfeead5f212e7e91505bd86c892cd61136cce319fae5e3d1::usad {
    struct USAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/v69wXs5gA-zerxEoYO4ySCtry0PO2wMntPdYz7C04L8";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/v69wXs5gA-zerxEoYO4ySCtry0PO2wMntPdYz7C04L8"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USAD>(arg0, 9, trim_right(b"USAD"), trim_right(b"USAD  "), trim_right(b"Usad"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USAD>>(0x2::coin::mint<USAD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USAD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAD>>(v4);
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

