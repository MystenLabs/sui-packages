module 0x9372e64b088e3a7f43126df69eaf93bf0c1f514c34d02439fcac0684915d9a0a::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ME4vXsaaf9vTeBbiektJBJbw6SFrYPeaqj7cM2Ypump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAO         ")))), trim_right(b"MAO                             "), trim_right(x"48692c204927616d204d414f0a4d656574204d414f2c2074686520756e6c75636b696573742063617420747261646572206f6e2074686520536f6c616e61206e6574776f726b2e2046726f6d206865617274627265616b20696e20726f6d616e636520746f206120736572696573206f6620756e666f7274756e617465207472616465732c204d414f2773206c696665206973206120726f6c6c6572636f6173746572206f66206d6973686170732e20446573706974652068697320636f6e7374616e7420626164206c75636b2c207468697320636174206b6565707320676f696e672c20656d626f6479696e672074686520737069726974206f662070657273697374656e636520616e642068756d6f722e204d414f206d6179206e6f7420616c77617973206c616e64206f6e2068697320666565742c2062757420686973"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v4);
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

