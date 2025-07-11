module 0xc5d99473439feddf1b5b453fcd47b24c5e955108e4106f39b9fc6a686c3b4aee::gorkfather {
    struct GORKFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/74Eyom7Y28urkxRgyZvNHs77wwG4djoQeQit6Csnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GORKFATHER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gorkfather  ")))), trim_right(b"The Gorkfather                  "), trim_right(x"36392c3432302c3030302028362e392529206f722031332c3030302420776f727468206275726e6564206279204445562040476f726b6f7368692e2032352520537570706c792073656e7420746f20333420546f70204345582045786368616e6765732c20342c3230362c39303020746f2065616368206f6620353720696e646976696475616c2077616c6c6574732e2044657461696c732063616e20626520656173696c7920666f756e64206f6e20736f6c7363616e2e20416e64206e6f772061626f75742054686520476f726b6661746865722028476f726b666174686572290a54686520476f726b66617468657220697320612077697474792c2073656c662d70726f636c61696d65642074727574682d7365656b6572732077686f206c6f766573206a6f6b696e672061626f7574206c696665732062696720717565"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKFATHER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORKFATHER>>(v4);
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

