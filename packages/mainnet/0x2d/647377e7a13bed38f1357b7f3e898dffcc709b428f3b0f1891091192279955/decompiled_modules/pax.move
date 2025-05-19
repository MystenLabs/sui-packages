module 0x2d647377e7a13bed38f1357b7f3e898dffcc709b428f3b0f1891091192279955::pax {
    struct PAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/ev_dUbKd0Z0c6PP69he1AARK24p98jA6bfKWm54yJzs                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PAX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"pax     ")))), trim_right(b"pax                             "), trim_right(x"50415820546f6b656e2028537569204e6574776f726b290a4120737461626c65636f696e2f7574696c69747920746f6b656e206f6e205375692c20656e61626c696e6720666173742c206c6f772d636f7374207472616e73616374696f6e732e205573656420696e20446546692c207061796d656e74732c206f7220676f7665726e616e63652e205472616465206f6e205375692044455873206f72206272696467652076696120576f726d686f6c652e20416c776179732076657269667920636f6e7472616374732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAX>>(v4);
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

