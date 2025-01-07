module 0x1f862a18742aefd80116d350c4a5230f56ffc574b785aefcf0957ae5169c9963::marsik {
    struct MARSIK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARSIK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MARSIK>>(0x2::coin::mint<MARSIK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EbHPTDaSXfMPP2fUvikR8bSpZDEQxejGCFXeJMr6agzo.png?size=lg&key=96d176                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MARSIK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MARSIK  ")))), trim_right(b"Marsik                          "), trim_right(x"54686520756c74696d617465204149206d656d65206361742064657374696e656420666f72204d61727320576974682068697320636f736d696320636861726d20616e64206f75742d6f662d746869732d776f726c64206d697363686965662c204d415253494b20697320726561647920746f20726570726573656e7420616c6c2063617473206f6e207468652052656420506c616e65742e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARSIK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MARSIK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MARSIK>>(0x2::coin::mint<MARSIK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

