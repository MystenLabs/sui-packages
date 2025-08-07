module 0xf1ff6a2b6e62296798efd3aa106fb0caeea443d804bfffb4d1065fae0e0e29c4::apad {
    struct APAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: APAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f2c30fbe64c3e43f8f58fd572f90574fb8aabdfde40efb4fa7734bc193d9c6e1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<APAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"APAD        ")))), trim_right(b"AlphaPad                        "), trim_right(x"496e74726f647563696e6720416c70686150616420200a0a546865206d6f737420706f77657266756c20616e6420757365722d667269656e646c7920706c6174666f726d20746f206372656174652c206c61756e63682c20616e64206d616e61676520626f6e64696e6720637572766520746f6b656e7320746861742072657761726420796f7520616e6420796f757220686f6c646572732e204e6f20636f64652072657175697265642e200a0a546f6b656e6f6d6963733a0a0a372520746178206f6e206576657279206275792c2073656c6c2c20616e64207472616e736665720a353025206f6620726576656e756520646973747269627574656420746f20686f6c6465727320696e2024534f4c0a34352520697320616c6c6f636174656420746f206d61726b6574696e672074686520746f6b656e0a3525206275726e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APAD>>(v4);
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

