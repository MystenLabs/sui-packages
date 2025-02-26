module 0x87cbebac22c3c5cd53ef2a40ec3bbad5ba9e351fc5552f4006401e2f0f9395e7::pidog {
    struct PIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BF3cuisaDwngNiHTsqV8XPCVL2doJkfaiVHajd3Spump.png?claimId=G1hvH7WDjJcjUCef                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PIDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIDOG       ")))), trim_right(b"Pi Dog                          "), trim_right(x"57656c636f6d6520746f20746865205069446f6720436f6d6d756e6974792054616b65204f766572210a0a5069446f67202d3e20446f67206f6e20746865205069206e6574776f726b2c20746869732069732074686520666972737420646f672073686f776e20696e20506973206f6666696369616c2074776565742c206e6f7720776520656d706f776572206974212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIDOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIDOG>>(v4);
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

