module 0x92b9270694173314fecaef9cc36f9b939190fe46692b6f2c2a56359cc3e3de66::marian {
    struct MARIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"mt8zuR9P6O6kF-OG                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MARIAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Marian      ")))), trim_right(b"MAID MARIAN                     "), trim_right(x"4d616964204d617269616e20616e64204e6577204469676974616c2043757272656e63793a2041204e6f626c6520476f616c20746f2048656c702074686520506f6f720d0a0d0a496e20616e20696e6e6f766174697665206d6f76652c204d616964204d617269616e2c206120706f70756c61722066696775726520696e2074686520776f726c64206f66206469676974616c2063757272656e636965732c20686173206c61756e6368656420686572206e65772063727970746f63757272656e63792061696d656420617420616368696576696e672061206e6f626c6520736f6369616c20616e642068756d616e6974617269616e20676f616c2e20546865207072696d617279206964656120626568696e6420746869732063757272656e637920697320746f20726564697374726962757465207765616c74682066726f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIAN>>(v4);
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

