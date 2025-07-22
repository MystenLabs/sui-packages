module 0xdd6af45112318aa8677fa390df2346b03be0e3ac5dd44a19199115fdb81a27d5::pumpball {
    struct PUMPBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/JE3WE9Ksj1tzF7ouMdHBwBHs3qgwmv7c3TtXwqcpPPw4.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPBALL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMPBALL    ")))), trim_right(b"PumpFun Balloon Challenge       "), trim_right(x"57656c636f6d6520746f2050756d7046756e2042616c6c6f6f6e204368616c6c656e676520746865206f6e6c79206d656d65636f696e2077686572652062616c6c6f6f6e7320646563696465207468652068797065210a0a5765726520676f696e67206c697665206f6e2050756d7066756e2c2070756d70696e6720677265656e20262077686974652062616c6c6f6f6e73206e6f6e2073746f702e20427574206865726573207468652074776973743a20617420657665727920696e73616e65206d61726b657420636170206d696c6573746f6e652c2061206d61737369766520636c7573746572206f662062616c6c6f6f6e73206765747320706f70706564204c49564520616e6420746865206368616f73206f6e6c792067657473206269676765722e0a0a4869742035304b204d633f20506f702e0a52656163682036"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPBALL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPBALL>>(v4);
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

