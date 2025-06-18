module 0x2225275a329b6794cc567033d537479c67b5545d3c73a8bb999fec9a623a0600::ggwp {
    struct GGWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGWP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FyWXxvePAqn9frSQqr56g748cDKEpwMURCTsQWY9pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GGWP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GGWP        ")))), trim_right(b"Good Game Well Played           "), trim_right(x"43686f6f736520796f7572206865726f2e2042757920796f757220746f6b656e2e20436f6e7175657220746865206172656e612e0a0a46726f6d2074686520646570746873206f6620746865206a756e676c6520746f2074686520666c616d6573206f662074686520756e646572776f726c642c20746865206c6567656e6473206f6620446f7461207269736520616761696e746869732074696d652c206f6e2074686520626c6f636b636861696e2e205069636b20796f7572206368616d70696f6e2c206772616220796f7572207368617265206f662024474757502c20616e64207072657061726520666f722074686520756c74696d617465204e46542064726f702e205768657468657220796f7572652061204372797374616c204d616964656e2073696d70206f72206120507564676520656e6a6f796f6f6f722c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGWP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGWP>>(v4);
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

