module 0x98cd7e6097603df24d37f4348a2fe06a2f868d0ea92eedc5b735a8cd2d741f32::lavc {
    struct LAVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAVC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/DdBn7sf1gmtVZCVFcceZl2jS5WHnqrP_nBQ5SDOuN2o";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/DdBn7sf1gmtVZCVFcceZl2jS5WHnqrP_nBQ5SDOuN2o"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LAVC>(arg0, 8, trim_right(b"LAVC"), trim_right(b"LACV"), trim_right(b"LAVCCTI"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (2000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LAVC>>(0x2::coin::mint<LAVC>(&mut v5, 2000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAVC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LAVC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAVC>>(v4);
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

