module 0x3006436ec51e1bf80b0c6ab4b397cf2a6c7f1f60452fb6af51a4919611307981::bonkersa {
    struct BONKERSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKERSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2ztfMWS76tFVd84MNefvjiNHDCNwQ6ShtWXMQGKFQnjL.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BONKERSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bonkers     ")))), trim_right(b"BonkersMemeToken                "), trim_right(x"426f6e6b657273206973206120737570657220766972616c206d656d6520636f696e206261736564206f6e2061206368617269736d61746963204672656e63682042756c6c646f6720776f726b696e6720617320616e206f7665726c6f7264206f6620686973207472756c7920756e72756c792074726962616c206d696e696f6e73206669676874696e6720616d6f6e6773742065616368206f746865722e0a0a5468657365206d696e696f6e7320676f2061726f756e64206669676874696e6720696e2074726962657320747279696e6720746f20636f6e71756572206f746865722076696c6c616765732e0a0a54686973206d656d6520766973696f6e2077617320666f756e646564206f6e206272696e67696e6720746f6765746865722061207374726f6e6720616e64206c6f79616c20636f6d6d756e697479206f66"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKERSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKERSA>>(v4);
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

