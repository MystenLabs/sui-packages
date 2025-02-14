module 0x3204e61931bc144e0869c0a95aeea7c35bf80d4dc4cc9b28df7e621c5dabf18c::cobra {
    struct COBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ct1M1TDIbrSTnZFC                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COBRA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COBRA       ")))), trim_right(b"Cobra Kai                       "), trim_right(x"2a2a436f627261204b616920436f696e3a20537472696b652046697273742e20537472696b6520486172642e204e6f204d657263792e202a2a20200d0a0d0a53746570206f6e746f2074686520626c6f636b636861696e20646f6a6f2077697468202a2a436f627261204b616920436f696e2a2a74686520756c74696d617465206d656d6520636f696e20696e73706972656420627920746865202a2a727574686c65737320737069726974206f6620766963746f72792a2a21205768657468657220796f7527726520612063727970746f20626c61636b2062656c74206f72206a757374207374617274696e6720796f7572206a6f75726e65792c207468697320746f6b656e20697320616c6c2061626f7574202a2a646f6d696e6174696e6720746865206d61726b65742c2073686f77696e67206e6f20666561722c2061"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBRA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBRA>>(v4);
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

