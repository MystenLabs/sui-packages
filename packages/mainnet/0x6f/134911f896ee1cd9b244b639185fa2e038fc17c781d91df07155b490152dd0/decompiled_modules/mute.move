module 0x6f134911f896ee1cd9b244b639185fa2e038fc17c781d91df07155b490152dd0::mute {
    struct MUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AMp6nNmvohjGYEnfDZ635nykM1msQTRAhmquUnHBpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUTE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MUTE        ")))), trim_right(b"MUT8 Virus                      "), trim_right(x"4d5554382056697275732e205468657265206973206e6f20637572652e0a0a41206d656d657469632076697275732072656c6561736564206f6e20536f6c616e612e0a426f726e2066726f6d20636f6e7461696e6d656e74206661696c7572652c20244d5554382073707265616473207468726f756768206d656d65732c2072616964732c20616e642062656c6965662e0a546869732069736e74206120746f6b656e202069747320616e206f7574627265616b2e0a0a244d5554382069732061206d656d652d64726976656e2c206e61727261746976652d706f776572656420746f6b656e206275696c74206f6e20536f6c616e612020626c656e64696e67206469676974616c206c6f7265207769746820766972616c20636f6d6d756e69747920656e657267792e0a4974206973206e6f74206a757374206120636f696e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTE>>(v4);
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

