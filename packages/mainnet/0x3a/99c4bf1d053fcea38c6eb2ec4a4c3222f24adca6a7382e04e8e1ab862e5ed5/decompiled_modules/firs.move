module 0x3a99c4bf1d053fcea38c6eb2ec4a4c3222f24adca6a7382e04e8e1ab862e5ed5::firs {
    struct FIRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DicgtwaA1FXC7JERt9P9TJpA9vAFiVgWQ1T9kjLv51SL.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FIRS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FIRS        ")))), trim_right(b"FUCK THE IRS                    "), trim_right(x"4675636b2049525320436f696e202846495224290a4120726562656c6c696f7573206d656d65636f696e206d61646520666f72207468652070656f706c652077686f76652068616420656e6f756768206f662074617865732c206175646974732c20616e6420746861742062696720676f7665726e6d656e74206f76657272656163682e200a0a426f726e206f7574206f66206672757374726174696f6e20616e64206675656c65642062792066726565646f6d2c2046495224206973206865726520746f2072656d696e6420796f75207468617420796f7572207765616c746820697320796f75727320746f206b65657020206e6f206d617474657220776861742074686520746178206d616e20736179732e200a0a4c696d6974656420737570706c792c20756e6c696d69746564206d656d657320202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRS>>(v4);
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

