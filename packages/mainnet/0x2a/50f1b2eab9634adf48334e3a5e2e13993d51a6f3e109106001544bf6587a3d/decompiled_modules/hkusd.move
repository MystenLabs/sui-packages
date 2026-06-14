module 0x2a50f1b2eab9634adf48334e3a5e2e13993d51a6f3e109106001544bf6587a3d::hkusd {
    struct HKUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/OLtfpsF-k3c94ejbYi1mOnXZjy_zV5mqht2FSEk-a-w";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/OLtfpsF-k3c94ejbYi1mOnXZjy_zV5mqht2FSEk-a-w"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<HKUSD>(arg0, 9, trim_right(b"HKUSD"), trim_right(b"HKUSD  "), trim_right(b"hh"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HKUSD>>(0x2::coin::mint<HKUSD>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKUSD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HKUSD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HKUSD>>(v4);
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

