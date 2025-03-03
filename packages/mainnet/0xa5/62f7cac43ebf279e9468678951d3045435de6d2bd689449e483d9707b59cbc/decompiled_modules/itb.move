module 0xa562f7cac43ebf279e9468678951d3045435de6d2bd689449e483d9707b59cbc::itb {
    struct ITB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6Agsr4EXaY1DoU4WvixH1PQ2WPYtLqgC14P7b3Tbpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ITB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ITB         ")))), trim_right(b"IntellyBot Token                "), trim_right(x"496e74656c6c79426f7420546f6b656e2028495442290a54686520496e74656c6c79426f7420546f6b656e20756e6c6f636b732061636365737320746f207072656d69756d2054726164696e6756696577207363726970747320616e6420696e64696361746f72732c2064657369676e656420746f20656e68616e636520796f75722074726164696e672073747261746567696573207769746820706f77657266756c2041492d64726976656e20696e7369676874732e205768657468657220796f75277265206120626567696e6e6572206f7220616e20657870657274207472616465722c20746865736520746f6f6c7320656d706f77657220796f7520746f206d616b6520736d6172746572206465636973696f6e7320696e20746865206d61726b65742e20537562736372697074696f6e20726571756972656d656e74"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITB>>(v4);
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

