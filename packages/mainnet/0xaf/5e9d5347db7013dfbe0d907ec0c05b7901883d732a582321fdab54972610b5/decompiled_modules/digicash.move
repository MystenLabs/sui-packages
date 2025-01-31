module 0xaf5e9d5347db7013dfbe0d907ec0c05b7901883d732a582321fdab54972610b5::digicash {
    struct DIGICASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGICASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EjJhYzvz2vhmZrq8fP7offFpeuTxdP1dWJuW1q6w8cHH.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DIGICASH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DIGICASH    ")))), trim_right(b"DIGICASH INC.                   "), trim_right(x"546865206669727374206469676974616c2063757272656e63792065766572207761732065436173682c206372656174656420627920446176696420436861756d20696e20313938332e20436861756d2c20612063727970746f677261706865722c20646576656c6f7065642074686520636f6e63657074206f6620616e6f6e796d6f7573206469676974616c206d6f6e6579207468726f7567682068697320636f6d70616e7920446967694361736820696e207468652031393930732e20654361736820616c6c6f776564207472616e73616374696f6e7320746f206265206d616465206469676974616c6c79207768696c65206d61696e7461696e696e67207573657220707269766163792e0a0a4265666f7265205361746f736869204e616b616d6f746f20616e6420426974636f696e2c207468657265207761732061"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGICASH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIGICASH>>(v4);
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

