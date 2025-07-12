module 0xbb92c059aa294a2d2d31f37d295e1e5e39b023fa301c1ead8b2dc35985dc891d::pumphouse {
    struct PUMPHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9nDhuzqS4upxYCn3rdWvazRNDAwPHWhnBDHxPzUtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPHOUSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMPHOUSE   ")))), trim_right(b"PUMPHOUSE                       "), trim_right(x"50756d7066756e2773204865617274626561740a5374657020696e746f205468652050756d70686f7573652c206120756e69717565206469676974616c206477656c6c696e6720776865726520746865206c6567656e64617279207472656e63682077617272696f7220416c6f6e20686173206c6169642068697320726f6f74732e20546869732069736e2774206a75737420616e7920686f7573653b206974277320612074657374616d656e7420746f20726573696c69656e63652c20612073616e63747561727920666f7267656420696e20746865206669726573206f66206469676974616c20626174746c652c20616e6420612076696272616e742068756220666f72207468652050756d7066756e20636f6d6d756e6974792e2020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPHOUSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPHOUSE>>(v4);
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

