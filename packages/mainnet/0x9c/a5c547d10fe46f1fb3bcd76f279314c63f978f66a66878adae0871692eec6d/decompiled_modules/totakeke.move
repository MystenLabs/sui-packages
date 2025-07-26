module 0x9ca5c547d10fe46f1fb3bcd76f279314c63f978f66a66878adae0871692eec6d::totakeke {
    struct TOTAKEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTAKEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7q7gMKcuhDht9zijMCG1ibnJgWfRw1xsHcfpwHrhbonk.png?claimId=LxU1lZ8TvhAxUTOv                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOTAKEKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Totakeke    ")))), trim_right(b"Dark Cheems                     "), trim_right(x"4c6f726520736179732042616c6c747a652028616b6120436865656d732920696e73706972656420426f6e6b2e204869732062726f7468657261206461726b205368696261206e616d656420546f74616b656b6577617320726563656e746c7920636f6e6669726d6564206279206f776e6572200a4048617a7a6965335375736869206f6e20582e204d616e7920546f74616b656b6520746f6b656e7320666f6c6c6f776564206f6e20426f6e6b2c20627574207468697320434120697320746865204f47746865206669727374206465706c6f796564206f6e20616e7920636861696e2120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTAKEKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTAKEKE>>(v4);
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

