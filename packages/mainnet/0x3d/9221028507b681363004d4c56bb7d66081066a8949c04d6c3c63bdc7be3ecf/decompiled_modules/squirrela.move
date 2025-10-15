module 0x3d9221028507b681363004d4c56bb7d66081066a8949c04d6c3c63bdc7be3ecf::squirrela {
    struct SQUIRRELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRRELA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"82378388eeb95b0ef602835f6b48d1963b28c7318adae1ed83722980908a47e3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SQUIRRELA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"squirrel    ")))), trim_right(b"disintegrating squirrel         "), trim_right(x"457665727920646567656e20616e64206576657279207472656e63686572206b6e6f777320746865207061696e2e20596f752066616465206120636f696e2c2063616c6c20697420646561642c206c617567682061742069742c20616e64207468656e20796f7520776174636820697420676f2031303078207768696c6520796f7520736974207468657265207475726e696e6720746f20647573742e205468697320646973696e746567726174656420737175697272656c206973206c69746572616c6c79207468652070657266656374207265616374696f6e20666f722069742e0a0a5765766520616c6c20666164656420612073656e646f722c20736f6c642074686520626f74746f6d2c20626f756768742074686520746f702c206f72206a75737420646f6e6520736f6d657468696e6720627261696e2064656164"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRRELA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRRELA>>(v4);
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

