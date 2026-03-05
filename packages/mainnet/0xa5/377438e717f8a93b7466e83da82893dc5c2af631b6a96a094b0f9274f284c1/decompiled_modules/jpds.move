module 0xa5377438e717f8a93b7466e83da82893dc5c2af631b6a96a094b0f9274f284c1::jpds {
    struct JPDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/Q2mjjX-p8PtUhUh7SbPUYGlOrMCP-dVKkBzlhaDtVrY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Q2mjjX-p8PtUhUh7SbPUYGlOrMCP-dVKkBzlhaDtVrY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JPDS>(arg0, 9, trim_right(b"JPDS"), trim_right(b"JPDS  "), trim_right(b"ssjsklfnsvlcmsCdslslflcvkf"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JPDS>>(0x2::coin::mint<JPDS>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPDS>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JPDS>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPDS>>(v4);
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

