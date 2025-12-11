module 0xe62a55bb38a8207bc9e5f69bd994a3e374a9b2faafb13ce143c665b3ccdfcbd6::yortexai {
    struct YORTEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YORTEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"caf48ba706f327136b30b3f930f0e43bea77f3741f722d5590927268edca8324                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YORTEXAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YORTEXAI    ")))), trim_right(b"YortexAI                        "), trim_right(x"596f7274657841492020536f6c616e6120496e74656c6c6967656e636520506c6174666f726d2e0a416476616e6365642041492d706f776572656420746f6f6c7320666f722077616c6c657420747261636b696e672c20706f7274666f6c696f20666f72656e736963732c20746f6b656e20766572696669636174696f6e2c20616e6420686967682d6672657175656e6379206d61726b657420646961676e6f7374696373206f6e20536f6c616e612e20507265636973696f6e20616e616c797469637320656e67696e656572656420666f7220666173742c20766f6c6174696c6520656e7669726f6e6d656e74732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YORTEXAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YORTEXAI>>(v4);
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

