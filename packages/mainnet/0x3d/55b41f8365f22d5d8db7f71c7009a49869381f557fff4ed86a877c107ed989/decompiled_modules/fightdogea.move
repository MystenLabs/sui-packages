module 0x3d55b41f8365f22d5d8db7f71c7009a49869381f557fff4ed86a877c107ed989::fightdogea {
    struct FIGHTDOGEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHTDOGEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9v2PLsHLDi3xsFPk2ea8ZsrteLz215C5edyAaZR7pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FIGHTDOGEA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FIGHTDOGE   ")))), trim_right(b"FIGHTDOGE                       "), trim_right(x"2241206669676874657220646f672066726f6d2074686520737472656574732e204120736d75672063617420626568696e6420746865206d61736b2e220a54686520636861696e206973206e6f742062696720656e6f75676820666f7220626f74682e204f6e652077696c6c2066616c6c2e0a0a20244649474854444f474520737465707320696e746f20746865206172656e6120746f20736574746c652074686973206f6e636520616e6420666f7220616c6c2e0a203230304d20746f6b656e73206c6f636b656420666f72206c697374696e6720206e6f20657869742c206e6f206261636b696e6720646f776e2e0a4f6e6c7920666f72776172642e204f6e6c79207761722e0a0a204d656d6520505650202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHTDOGEA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHTDOGEA>>(v4);
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

