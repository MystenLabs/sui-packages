module 0xbd33b1c44912bf3fc359489038ecb6a2627bded9c30384717804f6f17f29ac55::sight {
    struct SIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"qRSvGd4PvQfCzhfK                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIGHT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"sight       ")))), trim_right(b"SolanaSight                     "), trim_right(x"416476616e6365642c205265616c2d54696d6520496e7369676874732066726f6d20536f6c616e612053696768743a204e617669676174696e672074686520467574757265206f66204469676974616c2046696e616e636520546f6461792e0d0a0d0a20556e6c6f636b207468652066756c6c20706f776572206f6620536f6c616e615369676874207769746820736f6c616e61736967687420746f6b656e733a0d0a0d0a20546965726564204163636573733a2055736520736f6c616e61736967687420746f20756e6c6f636b207072656d69756d206461746120262066656174757265732e0d0a0d0a20476f7665726e616e63653a20566f7465206f6e20706c6174666f726d2075706461746573202620646576656c6f706d656e74207072696f7269746965732e20202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGHT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGHT>>(v4);
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

