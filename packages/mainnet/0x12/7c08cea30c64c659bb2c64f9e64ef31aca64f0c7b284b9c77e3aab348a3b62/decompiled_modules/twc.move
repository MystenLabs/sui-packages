module 0x127c08cea30c64c659bb2c64f9e64ef31aca64f0c7b284b9c77e3aab348a3b62::twc {
    struct TWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BVpNBmHqq77MJfL1QKim859NncFwsVcZXe72UUiGpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TWC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TWC         ")))), trim_right(b"Tradewave Capital PLC.          "), trim_right(x"496e74726f647563696e6720547261646577617665204361706974616c202d20412046616972204c61756e636820436f696e2077697468205265616c2d576f726c6420426f6e64205574696c69747921200a0a547261646577617665204361706974616c206973206e6f74206a75737420616e6f746865722063727970746f63757272656e63793b2069747320612067616d652d6368616e67657220696e2074686520776f726c64206f662066696e616e6365212057652061726520746872696c6c656420746f2070726573656e7420612066616972206c61756e636820636f696e2074686174207374616e6473206f7574207769746820756e69717565207265616c2d776f726c6420626f6e64207574696c6974792c20706f736974696f6e696e6720697473656c662061732061207265766f6c7574696f6e617279206173"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWC>>(v4);
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

