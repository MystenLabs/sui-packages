module 0x4fb15b0fee962683a39968b53270d009cab1b12c284fe7729c045cd3f2b2dfdd::frame {
    struct FRAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5ojc9UrtfeAVsTC8vdjrqsvGCkBpa4obdVy1Xwn2pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRAME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRAME       ")))), trim_right(b"FRAME IT                        "), trim_right(x"244652414d453a20546865204d656d6520436f696e204d617374657270696563650a0a426f726e2066726f6d206120766972616c20446f6765204e46542c20244652414d4520697320746865206d656d65636f696e2070726573657276696e67206d656d65206c6567656e6473206c696b6520446f676520616e642054524f4c4c464143452e20536c6f67616e3a2022496620697473206e6f74206672616d65642c20697473206e6f742066616d65642e2220416e6f6e796d6f757320646576732c202254686520456c6974652c222061696d20666f72206d656d657320616e64204c616d626f732e2046616b65204c6f75767265206465616c7320616e6420456c6f6e73206672616d6564202222206675656c2031303030782070756d70732e204a6f6b65206f72206172743f20244652414d45206973206d656d65206375"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAME>>(v4);
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

