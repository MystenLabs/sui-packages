module 0xc28317afb44632ed6fce3473a6036b4ae1928c95924c274d619a1fd7ce0f2c82::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5mfWKJrjVtpZo8EvwbytFWH5X6T8YecxrrYCgskjpump.png?claimId=-30NVDKOKLhmKDwY                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEGA        ")))), trim_right(b"Make Europe Great Again         "), trim_right(x"4d616b65204575726f706520477265617420416761696e20244d454741202d204974607320616e20696465612077686f73652074696d65206861732066696e616c6c7920636f6d652e200a0a456c6f6e204d75736b206d6164652074686520696465612061207265616c697479207768656e20686520747765657465642061626f757420244d4547412c2073686f77696e672068697320737570706f727420746f206d696c6c696f6e73206f66204575726f7065616e732e200a0a43616e207468697320626520746865207475726e206f6620746865207469646520666f72204575726f70653f2043616e2074686579206765742061206d6f76656d656e7420676f696e67206c696b65204d4147413f0a0a497320244d45474120746865206f6e6c79206d656d65636f696e20696e2074686520776f726c6420746861742063"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

