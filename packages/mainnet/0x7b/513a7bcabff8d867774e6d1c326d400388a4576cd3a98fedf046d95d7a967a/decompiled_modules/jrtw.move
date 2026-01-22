module 0x7b513a7bcabff8d867774e6d1c326d400388a4576cd3a98fedf046d95d7a967a::jrtw {
    struct JRTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JRTW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/2kG8EWaoHx8sVDgVv4J_dwKMvfzMV7WWpUDC4nI4Xjs";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/2kG8EWaoHx8sVDgVv4J_dwKMvfzMV7WWpUDC4nI4Xjs"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<JRTW>(arg0, 9, trim_right(b"JRTW"), trim_right(b"JRTW  "), trim_right(b"JTtofan"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JRTW>>(0x2::coin::mint<JRTW>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JRTW>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JRTW>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JRTW>>(v4);
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

