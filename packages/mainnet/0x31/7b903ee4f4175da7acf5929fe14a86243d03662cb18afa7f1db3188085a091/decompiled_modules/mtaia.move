module 0x317b903ee4f4175da7acf5929fe14a86243d03662cb18afa7f1db3188085a091::mtaia {
    struct MTAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6KWLSeqyvdbzj2a7BJYPuNoKn3G7kmaiNw87XHJ3pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MTAIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MTAI        ")))), trim_right(b"Melania Trump AI                "), trim_right(x"54686520746f6b656e206973204d656c616e6961205472756d702041492c20616e6420697320616e2054656c656772616d2063686174626f740a6167656e74206261736564206f6e204d656c616e6961205472756d702c20746861740a726573706f6e647320746f2065766572792073696e676c65207175657374696f6e2061736b65640a696e205447207769746820696e74656c6c6967656e63652c20616e6420696e20610a68756d616e6c696b65207761792e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTAIA>>(v4);
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

