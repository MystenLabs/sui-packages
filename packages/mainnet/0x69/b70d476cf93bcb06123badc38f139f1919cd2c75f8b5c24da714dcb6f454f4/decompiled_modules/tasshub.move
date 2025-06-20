module 0x69b70d476cf93bcb06123badc38f139f1919cd2c75f8b5c24da714dcb6f454f4::tasshub {
    struct TASSHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASSHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FKNfAwb8TmjYkj11V4NiTz4TgrLWTWgm2NRwAD9epump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TASSHUB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TASSHUB     ")))), trim_right(b"TASS HUB                        "), trim_right(x"546173734875622069732074686520756c74696d6174652043726561746f7220506c6174666f726d204261736564206f6e207765623320646576656c6f706d656e74200a2020202020202020202020202020202020202020200a2020202020202020202054617373687562206973206275696c64696e67207468652066757475726520666f7220636f6e74656e742063726561746f7273206f6620616c6c206b696e6473210a202020202020202020202020202020202020202020202020202020202020202020416e6420736572766963657320666f7220616c6c2063727970746f2070726f6a656374730a0a202020202020202020205441535348554253204d41494e20544f4b454e20464f5220534543555245205041594d454e54204f4e2054484520504c4154464f524d20202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASSHUB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASSHUB>>(v4);
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

