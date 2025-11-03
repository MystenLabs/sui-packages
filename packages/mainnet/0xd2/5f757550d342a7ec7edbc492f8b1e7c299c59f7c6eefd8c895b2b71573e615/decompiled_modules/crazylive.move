module 0xd25f757550d342a7ec7edbc492f8b1e7c299c59f7c6eefd8c895b2b71573e615::crazylive {
    struct CRAZYLIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZYLIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8fece7d198fd16cb5d0a36606b84c25f9f2cd659d8431da61f759b21f727ffd4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CRAZYLIVE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"crazylive   ")))), trim_right(b"Crazy live                      "), trim_right(x"4372617a796c69766520436f696e2028434c20546f6b656e2920200a4372617a79204c6976653a20456d706f776572696e67204368696e65736520496e766573746f7273207769746820616e204149204167656e742057652061726520616e204149204167656e742d64726976656e20696e766573746d656e7420636f6d6d756e6974792064656469636174656420746f2070726f766964696e6720736d617274657220737472617465676965732c206175746f6d617465642074726164696e6720736f6c7574696f6e732c20616e64207461696c6f72656420656475636174696f6e20666f72204368696e65736520696e766573746f72732e0a546865205765623320636f6d6d756e69747920746f6b656e20666f7220676c6f62616c204368696e65736520696e766573746f72732e0a4275696c74206f6e20536f6c616e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZYLIVE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZYLIVE>>(v4);
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

