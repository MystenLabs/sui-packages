module 0x5ec343bb14e86f2e8d2a5dfb24ca6d41b41d675638c6e86f20ad3ed989b4ab42::yasda {
    struct YASDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YASDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6asAsATJ8g2jJX5uxRFJ7EebNNp9EkMJHVg1WH1Ypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YASDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"yasda       ")))), trim_right(b"fuck cancer                     "), trim_right(x"4f6e65206c617374207468696e672e200a492077616e7420746f20736179207468616e6b20796f752c207468616e6b20796f7520666f7220746869732077696c64206a6f75726e65792077652068617665206265656e207468726f75676820746f676574686572200a466f722065766572796f6e65206f6e65206f6620796f75200a416c6c206f6620796f75277665206265656e20612070617274206f66206d79206c696665200a412063686170746572206f66206d7920626f6f6b20616e642049276c6c20636865726973682065766572792070616765206f662069740a492062656174207927616c6c20746f2075702074686572652c20646f6e277420626520736f206661737420746f20666f6c6c6f77206d6520492077616e7420736f6d65206d652074696d65207468657265200a556e74696c206e6578742074696d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YASDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YASDA>>(v4);
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

