module 0xf9460ed0f5cd9b2443d57ef908efc736b9b248d2ac60317371b8757fff9244f0::dogcoin {
    struct DOGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GZ5TC9wg6vZc8adiDiVvQBm3tb5akA6PD52ENmD5pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGCOIN     ")))), trim_right(b"DOG COIN                        "), trim_right(x"446f20796f75206c696b65203f20446f20796f75206c696b652063727970746f3f205468656e206772616220736f6d652024444f47434f494e20616e6420686f6c64206f6e20746f206974206c696b6520796f7572202062656c6f7665642066757272792066616d696c79206d656d626572210a0a57652077696c6c20626520646f696e6720646f6e6174696f6e732065766572792035306b20696e206d61726b6574206361702067726f77746820746f206c6f63616c207368656c74657273206c697665206f6e2073706163657320616c6c206163726f7373207468652020556e697465642053746174657321200a0a44657620616e6420666c6f6f7220686f6c646572732077696c6c2062757920373725206f6620737570706c7920746f20656e737572652061207361666520706c61636520746f206275792c20617320"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGCOIN>>(v4);
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

