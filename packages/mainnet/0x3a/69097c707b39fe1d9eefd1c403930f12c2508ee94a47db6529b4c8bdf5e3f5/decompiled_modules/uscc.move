module 0x3a69097c707b39fe1d9eefd1c403930f12c2508ee94a47db6529b4c8bdf5e3f5::uscc {
    struct USCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USCC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/WU5rO8Yn9aYzwrIOL-ac3bHiv4xNF2n_DRKzp0HAZIY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/WU5rO8Yn9aYzwrIOL-ac3bHiv4xNF2n_DRKzp0HAZIY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USCC>(arg0, 9, trim_right(b"USCC"), trim_right(b"USCC  "), trim_right(b"USCC "), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USCC>>(0x2::coin::mint<USCC>(&mut v5, 1000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USCC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USCC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USCC>>(v4);
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

