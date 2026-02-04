module 0x3e0580e1106122624783f1925d249f4eaa5e8b069deb19f82a19bd8614782f9e::nxjt {
    struct NXJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXJT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/2kG8EWaoHx8sVDgVv4J_dwKMvfzMV7WWpUDC4nI4Xjs";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/2kG8EWaoHx8sVDgVv4J_dwKMvfzMV7WWpUDC4nI4Xjs"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<NXJT>(arg0, 9, trim_right(b"NXJT"), trim_right(b"NXJT  "), trim_right(b"NXJTGOTOFAN"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NXJT>>(0x2::coin::mint<NXJT>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXJT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NXJT>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NXJT>>(v4);
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

