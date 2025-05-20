module 0x964d93e50e731b9e8a69c118f2f958106392887ddd1afbd8f662dbaf52b8ae98::gingr {
    struct GINGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"34fcac920c2ec49c2c46325c72bc00285094b22449b77a83a8c519128a7ff4d1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GINGR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GINGR       ")))), trim_right(b"Gingafication                   "), trim_right(x"47696e676572732061726520426c61636b2120486f6c642074686520736561736f6e696e672c2074686520706f7461746f2073616c616420697320746f6f2073706963792c20636f6f6b6f75747320676f6e6e61206265206c697420746869732073756d6d6572212121205468697320746f70696320676f696e6720766972616c206f6e2054696b546f6b206761696e696e67206d696c6c696f6e73206f662076696577732121210a0a49545320534349454e434520202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGR>>(v4);
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

