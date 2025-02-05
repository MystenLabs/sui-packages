module 0x85060bf4d90c6ce1f31707230990a79d9b914a5da534ef01d6ede0b3f54aaf63::moshi {
    struct MOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8SM5zQerbmduhBQjWZf2RwmgheSVXkhVVSx9BFGmQoyW.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOSHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOSHI       ")))), trim_right(b"Moshi                           "), trim_right(x"204d6f7368693a2054686520556e697665727365206f66205472616e73666f726d6174696f6e0a0a4d6f736869206973206d6f7265207468616e206120746f6b656e3b20697427732061206a6f75726e657920696e746f206120756e69766572736520776865726520647265616d732065766f6c766520696e746f207265616c6974792e204275696c74206f6e2074686520536f6c616e6120626c6f636b636861696e2c204d6f73686920656d626f646965732074686520617274206f66207472616e73666f726d6174696f6e2c206120636f6d6d756e6974792d64726976656e206c6567656e6420677569646564206279207472616e73706172656e63792c20696e6e6f766174696f6e2c20616e6420707572706f73652e0a0a20417320677561726469616e73206f66207468697320636f736d696320647265616d2c2074"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSHI>>(v4);
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

