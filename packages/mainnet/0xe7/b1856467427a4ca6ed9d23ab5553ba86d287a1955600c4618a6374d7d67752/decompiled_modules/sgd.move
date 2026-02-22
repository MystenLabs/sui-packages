module 0xe7b1856467427a4ca6ed9d23ab5553ba86d287a1955600c4618a6374d7d67752::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/iqliAc_FHoJ3heJ33iXG3xdSn6pfekFWJhBCHdl480g";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/iqliAc_FHoJ3heJ33iXG3xdSn6pfekFWJhBCHdl480g"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SGD>(arg0, 9, trim_right(b"SGD"), trim_right(b"SGD  "), trim_right(b"SGD is the third most traded currency in the world. It is also a legal tender and is considered a second-best currency for long-term investors to hold."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SGD>>(0x2::coin::mint<SGD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v4);
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

