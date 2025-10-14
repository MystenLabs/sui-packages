module 0x66754e7a0f08e03140f7f375f08ca5e5313456fcda2a555b5fb61c1789149fd1::rbg {
    struct RBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5d5e9eb3ac4bc58d2d198a46af8f773a9a1ee39a728317b731e11431386143b4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RBG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RBG         ")))), trim_right(b"Rebuild Gaza                    "), trim_right(x"324d20466f6c6c6f7765642053747265616d6572206c6f6f6b696e6720746f2052656275696c642048697320486f75736520696e2047415a4120616e642068656c702070656f706c652061726f756e642068696d20746f20646f20736f2e0a0a324d2b20546172676574202d20383025206f66205265776172647320746f77617264732068656c70696e672072656275696c742074686520686f75736520616e642068656c70206f746865727320646f2c2032302520746f7761726473204d61726b6574696e672e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBG>>(v4);
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

