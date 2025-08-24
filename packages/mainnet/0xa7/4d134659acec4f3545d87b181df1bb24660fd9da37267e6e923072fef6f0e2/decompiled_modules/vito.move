module 0xa74d134659acec4f3545d87b181df1bb24660fd9da37267e6e923072fef6f0e2::vito {
    struct VITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EhRVjQcwVieD9zFxjnKQVoUhaSeYrWoiDBEeeqkupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VITO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VITO        ")))), trim_right(b"THE BIONIC CAT                  "), trim_right(x"41207369782d796561722d6f6c642063617420686173206265636f6d6520616e20696e7465726e65742022737570657273746172222061732074686520666972737420696e204974616c7920746f20726563656976652074776f2070726f737468657469632068696e64206c65677320666f6c6c6f77696e67206120736572696f757320726f6164206163636964656e742e0a0a57697468206f766572203130306b206163746976652066616e7320617070726563696174696e67206869732073746f72792c20697420697320612074727565207a65726f20746f206865726f2073746f72792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VITO>>(v4);
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

