module 0x611785ef4c573d484904fa5fa19d097881446b556e1b95030050b409a48f903d::singlenigg {
    struct SINGLENIGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGLENIGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FrTP8M58zmvJLK1YKTJbTtPNhChmAgnCwWA8JG1spump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SINGLENIGG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SingleNigg  ")))), trim_right(b"$SingleNiggaz                   "), trim_right(x"54686973206f6e6520666f7220616c6c206d792073696e676c65206e696767617a206f6e2076616c656e74696e6573206461792e2050696d70696e272061696e277420656173792062757420796f7520646f6e277420676f7474612062652062726f6b65207768696c6520646f696e672069742e0a0a466f6c6c6f77206d65206f6e20582040426565746c6570696d702020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGLENIGG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINGLENIGG>>(v4);
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

