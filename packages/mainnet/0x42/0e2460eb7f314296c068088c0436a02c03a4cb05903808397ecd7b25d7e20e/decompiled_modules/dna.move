module 0x420e2460eb7f314296c068088c0436a02c03a4cb05903808397ecd7b25d7e20e::dna {
    struct DNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DiSetnR7k57wmfvywJhUVjPwWfg54SdQKxQdJEBYW23B.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DNA         ")))), trim_right(b"DNA                             "), trim_right(x"20444e41202824444e41292069732074686520626c75657072696e74206f66206c696665616e64206e6f772c2074686520666f756e646174696f6e206f662061207265766f6c7574696f6e617279206d656d6520636f696e21204272696467696e672062696f6c6f677920616e6420626c6f636b636861696e2c2024444e412063656c656272617465732074686520657373656e6365206f662065766f6c7574696f6e20616e6420696e6e6f766174696f6e2e200a0a576974682024444e412c207765726520726577726974696e67207468652063727970746f2067656e6f6d653a207472616e73706172656e742c20646563656e7472616c697a65642c20616e6420756e73746f707061626c652e2046726f6d20686f646c65727320746f20696e6e6f7661746f72732c207468697320746f6b656e20756e69746573206120"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNA>>(v4);
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

