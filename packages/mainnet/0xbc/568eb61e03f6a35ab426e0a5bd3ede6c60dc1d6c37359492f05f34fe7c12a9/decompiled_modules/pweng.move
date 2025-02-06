module 0xbc568eb61e03f6a35ab426e0a5bd3ede6c60dc1d6c37359492f05f34fe7c12a9::pweng {
    struct PWENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7Evu9KaRhfyYGZTnDo9Z13BAuJTsGADiB5H54rFJLfve.png?claimId=Q5Flp2Q7Mo50hirv                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PWENG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PWENG       ")))), trim_right(b"Pweng                           "), trim_right(x"436f6d6d756e6974792054616b656f766572212046697273742042697264206f6e20746865204d6f6f6e2120200a0a576869746520506170657273202620526f61646d61702062656c6f77200a0a232323205077656e672057686974652050617065720a0a232323232041627374726163740a5077656e672069732061206e6578742d67656e65726174696f6e2063727970746f63757272656e63792064657369676e656420746f20666163696c6974617465207365616d6c657373206469676974616c207472616e73616374696f6e73207768696c6520656e737572696e672073656375726974792c207363616c6162696c6974792c20616e6420636f6d6d756e69747920656e676167656d656e742e2054686973207768697465207061706572206f75746c696e65732074686520766973696f6e2c20746563686e6f6c6f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENG>>(v4);
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

