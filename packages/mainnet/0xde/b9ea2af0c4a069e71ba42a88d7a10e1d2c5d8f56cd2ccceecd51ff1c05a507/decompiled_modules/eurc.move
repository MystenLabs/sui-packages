module 0xdeb9ea2af0c4a069e71ba42a88d7a10e1d2c5d8f56cd2ccceecd51ff1c05a507::eurc {
    struct EURC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EURC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/ywIrzuvebjTVvqgeRhXgrxRjevD0gTJMH_GS7Aks5Ek";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ywIrzuvebjTVvqgeRhXgrxRjevD0gTJMH_GS7Aks5Ek"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<EURC>(arg0, 9, trim_right(b"EURC"), trim_right(b"Soleur"), trim_right(b"EURC "), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000008000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<EURC>>(0x2::coin::mint<EURC>(&mut v5, 10000008000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EURC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EURC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EURC>>(v4);
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

