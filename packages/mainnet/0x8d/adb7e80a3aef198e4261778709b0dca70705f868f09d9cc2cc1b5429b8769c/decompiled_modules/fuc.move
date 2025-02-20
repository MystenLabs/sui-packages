module 0x8dadb7e80a3aef198e4261778709b0dca70705f868f09d9cc2cc1b5429b8769c::fuc {
    struct FUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"KczRFsHJRr30OPrw                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FUC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FUC         ")))), trim_right(b"Fluffy Unicorn Coin             "), trim_right(x"23465543206973206120666169726c79206469737472696275746564206d656d65636f696e206d65616e7420666f7220667563276e2066756e2e204e6f7065207072652d73616c652e204e6f7065207465616d20616c6c6f636174696f6e2e205975702076696265732e20427579206f6e2074686520626f6e64696e672063757276652e2053656c6c206f6e2074686520626f6e64696e672063757276652e204175746f2d4c50206465706f7369747320616e64206275726e20626567696e20766961205261796469756d206174202436396b206d61726b6574206361702e20234655432c2023465543594541480d0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUC>>(v4);
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

