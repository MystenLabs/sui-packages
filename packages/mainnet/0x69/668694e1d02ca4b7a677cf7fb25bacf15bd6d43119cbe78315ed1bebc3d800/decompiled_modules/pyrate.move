module 0x69668694e1d02ca4b7a677cf7fb25bacf15bd6d43119cbe78315ed1bebc3d800::pyrate {
    struct PYRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"LqRHpuymKBiAbb69                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PYRATE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PYRATE      ")))), trim_right(b"PYRATE                          "), trim_right(x"24505952415445206973206120646567656e206d656d65202620644170702065636f73797374656d20746861742070726f76696465732065766572796f6e6520696e20576562332077697468202075736566756c207574696c6974792c206372656174656420746f206f76657274616b6520636f72727570742062616e6b732c20676f7665726e6d656e747320616e6420746865206e657720776f726c64206f72646572207363616d7320616e64206c6965732e0d0a0d0a57652077696c6c2066696e6420746865206772616e642024505952415445207472656173757265206174202436396d696c20616e64206c69766520746f676574686572206f6e206120245059524154452069736c616e64206472696e6b696e672072756d20616e64207361696c696e672074686520736561732e0d0a0d0a50617274206f66207468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYRATE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PYRATE>>(v4);
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

