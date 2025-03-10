module 0x4d40dae0360b8f4d161778993b3bcfd90bb042bb72055022366eb49ab4061068::chape {
    struct CHAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"NVyAiiWeu4P0-iGI                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHAPE       ")))), trim_right(b"CHONKAPE                        "), trim_right(x"4d656574202443484f4e4b4150452020746865206162736f6c75746520756e6974206f66206d656d6520636f696e7321202054686973207468696363207072696d6174652069736e74206a757374206865726520746f206d6f6e6b65792061726f756e643b20686573206865726520746f20646f6d696e61746520746865206a756e676c65206f662063727970746f2e20486f6c64202443484f4e4b41504520616e6420656d6272616365207468652063686f6e6b6265636175736520696e2074686973206a756e676c652c2073697a6520646f6573206d61747465722120202343484150450d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAPE>>(v4);
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

