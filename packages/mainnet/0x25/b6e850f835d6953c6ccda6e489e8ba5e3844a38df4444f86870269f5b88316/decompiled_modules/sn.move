module 0x25b6e850f835d6953c6ccda6e489e8ba5e3844a38df4444f86870269f5b88316::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3FDydrowEeGNwEnTxZj13cgMqKgmzw1ewEX3CHXtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SN          ")))), trim_right(b"Sir Nasty                       "), trim_right(x"536972204e61737479202824534e292069732061206e6578742d67656e206d656d65207574696c69747920746f6b656e206f6e20536f6c616e612c206275696c64696e6720612066756c6c2065636f73797374656d20666f72207374616b696e672c204e4654732c206d6572636820726577617264732c20616e6420636f6d6d756e69747920656d706f7765726d656e742e2049742773206d6f7265207468616e206120746f6b656e2020697427732061206d6f76656d656e742e0a0a46756c6c2050726f6a656374204465736372697074696f6e3a0a57656c636f6d6520746f2074686520534e2045636f73797374656d2c20706f77657265642062792024534e2020746865206f6666696369616c20746f6b656e206f66207369726e617374796d656d655f636f6d0a486572652773207768617420686f6c646572732067"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SN>>(v4);
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

