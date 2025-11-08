module 0xcdcb7dc02fb5179711d82ec9103698c2656a28c2e843289e41023b0ac7e1a19a::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"65e9244a844d4dfd1a930c277addbce15edb110e4441e5dadb7e9137062006c4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUFFI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUFFI       ")))), trim_right(b"PUFFI Coin                      "), trim_right(x"505546464920436f696e206973206120636f6d6d756e6974792d64726976656e20746f6b656e206f6e20536f6c616e612c206275696c74206f6e207472616e73706172656e63792c2074727573742c20616e6420636f6d70617373696f6e2e200a4120666169722d6c61756e63682070726f6a6563742077697468206e6f2070726573616c652c20666f6375736564206f6e207265616c207574696c6974792c206c6f6e672d7465726d2067726f7774682e0a0a0a0a5468696e6b204675747572652e205468696e6b2054727573742e205468696e6b2050554646492e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v4);
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

