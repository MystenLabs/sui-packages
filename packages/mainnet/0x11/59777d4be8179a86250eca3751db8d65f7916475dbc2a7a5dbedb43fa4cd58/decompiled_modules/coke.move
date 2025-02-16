module 0x1159777d4be8179a86250eca3751db8d65f7916475dbc2a7a5dbedb43fa4cd58::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2DJAyCbx9HkHiPsyJdZmgio9Pu9p1w6jujXDo5h4pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COKE        ")))), trim_right(b"Coke on Sol                     "), trim_right(x"563320537461727473204e6f772067757973212121210a3372642074696d652069732074686520636861726d20616e6420626574746572207468616e2065766572206265666f7265212024434f4b45206b65657073206f6e20726f6c6c696e67207468726f756768207468652062756d707320696e2074686520726f61642c2070726f76696e672069747320726573696c69656e63652e20576974682065616368206368616c6c656e67652c206974277320636c65617220746861742073746179696e6720666f637573656420616e642070757368696e6720666f727761726420697320746865206b65792e205472757374207468652070726f636573732c20737461792073686172702c20616e6420776174636820746865206d6f6d656e74756d206275696c64212054686520636f6d6d756e6974792069732063756c7420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKE>>(v4);
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

