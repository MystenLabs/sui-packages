module 0x5431931b4a68b28032e1e8e2893ca8cf1e5b665c85167e4b88d62f10ac78e4b5::svba {
    struct SVBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"m_hC0Ej0xlNCpWBi                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SVBA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SVB         ")))), trim_right(b"SOLVIBE                         "), trim_right(x"534f4c56494245202824535642292069732061203130302520666169722d6c61756e63686564206d656d6520636f696e206f6e20536f6c616e612e20200d0a2d204e6f2070726573616c652c206e6f207465616d2077616c6c6574732c206e6f2074617865732e202020200d0a2d20416c6c20746f6b656e732061726520696e2063697263756c6174696f6e2c206c697175696469747920697320736563757265642e20200d0a2d20436f6d6d756e6974792d64726976656e20616e642066756c6c7920646563656e7472616c697a65642e20200d0a2d204275696c7420666f72206c6f6e672d7465726d2073746162696c69747920616e642067726f7774682e0d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVBA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVBA>>(v4);
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

