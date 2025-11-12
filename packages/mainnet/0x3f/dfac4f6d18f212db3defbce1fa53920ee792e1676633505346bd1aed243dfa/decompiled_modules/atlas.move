module 0x3fdfac4f6d18f212db3defbce1fa53920ee792e1676633505346bd1aed243dfa::atlas {
    struct ATLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2748d1eca1ca82f2d8f7bc8bd09650252e5096ecb537e5aa9e31d3c48a952fae                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ATLAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ATLAS       ")))), trim_right(b"3I/ATLAS AI                     "), trim_right(x"496e7370697265642062792074686520696e7465727374656c6c617220636f6d65742033492f41544c41532c20776869636820736369656e74697374732062656c696576652063616d652066726f6d206265796f6e64206f757220736f6c61722073797374656d2e0a0909456c6f6e204d75736b20646973637573736564206974206f6e20546865204a6f6520526f67616e20457870657269656e63652c2068696e74696e6720697420636f756c6420626520736f6d657468696e67206e6f742066726f6d20686572652e0a0909546865206d797374657279206f6620697473206f726967696e2020616e642041497320726973652020636f6c6c69646520696e207468697320746f6b656e3a2033492f41544c4153204149203d20496e7465727374656c6c617220496e74656c6c6967656e6365206d656574732041727469"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLAS>>(v4);
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

