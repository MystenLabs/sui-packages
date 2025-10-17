module 0x91c8354633660d3e5a531a7e132d4cb6813198f43681df1f097f75ceee99a6cf::zol {
    struct ZOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f0be49bec058e4140347d721b0817db93d0a670d0870e9b2090e45cd53bd10a9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZOL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZOL         ")))), trim_right(b"ZOLANA                          "), trim_right(x"5a6f6c616e6120626f726e20696e736964652074686520536f6c616e61204c6162732065636f73797374656d207265706f2028323032302920776974682061726368697665642070726f6f66206f66205a6f6c2046696e616e6365202b20746865205a6f6c616e61206c6f676f20284465632032303231292e204f6e65206f6620746865206561726c6965737420747261636573207469656420746f20536f6c616e617320686973746f72792e0a0a4e6f7720636f6e74696e756f75736c7920656d627261636564206163726f737320746865206269676765737420536f6c616e612074696d656c696e65732c2061206e617272617469766520746861742070726f766573205a6f6c616e61206973206d6f7265207468616e2073706563756c6174696f6e2e0a0a436f6d6d756e6974792d64726976656e2e2042756c6c6973"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOL>>(v4);
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

