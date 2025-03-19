module 0xff31d92a5fb82e789f610f0f18266998634da6b5b2163d0757bd3f376fb325a7::cia {
    struct CIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6Zip2rHpQaqpqKmZUzfCUDX2tGyx1GQVpZgWHuQFNCiA.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CIA         ")))), trim_right(b"CIA.COM                         "), trim_right(x"2043494120546f6b656e20706f776572732074686520666972737420576562332077616c6c65742061757468656e7469636174656420656d61696c7320776865726520796f75206561726e2063727970746f206a75737420666f722072656164696e6720656d61696c732120204672656520726567697374726174696f6e7320617265206f70656e636c61696d20796f75722043494120656d61696c206e6f772120200a0a4261636b6564206279204349412e434f4d204c6162732c2061205553412d626173656420636f6d70616e792c207769746820373525206f6620737570706c79206c6f636b6564202620352d7965617220766573746564207368617265732c20656e737572696e67206c6f6e672d7465726d2073746162696c6974792e20576974682043494120456d61696c204d61726b6574706c6163652c20796f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIA>>(v4);
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

