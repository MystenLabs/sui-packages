module 0xf53ddaf946bb87d2418ab6198aced1d611e89cc4a378ab1dcbf321267e9e8d1e::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"i7Xl2w31yatAlQ7e                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Ye          ")))), trim_right(b"$Kanye                          "), trim_right(x"244b616e7965202054686520556e6f6666696369616c204b616e79652057657374204d656d6520436f696e0d0a41626f75743a244b616e79652069732074686520756c74696d617465206d656d6520636f696e20696e73706972656420627920746865206c6567656e64617279206172746973742c2066617368696f6e206d6f67756c2c20616e642063756c747572616c2069636f6e204b616e79652057657374202862757420746f74616c6c79206e6f7420656e646f727365642062792068696d292e204a757374206c696b6520596573206361726565722c207468697320636f696e20697320756e7072656469637461626c652c20636f6e74726f7665727369616c2c20616e6420616c77617973206d616b696e6720686561646c696e65732e205768657468657220697473206d6f6f6e696e67206c696b652047726164"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YE>>(v4);
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

