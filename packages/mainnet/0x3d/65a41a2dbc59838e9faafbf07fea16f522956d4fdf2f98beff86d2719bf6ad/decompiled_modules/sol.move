module 0x3d65a41a2dbc59838e9faafbf07fea16f522956d4fdf2f98beff86d2719bf6ad::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/RtfJm2p8wTzCmzBG1ub6QfAwqmg5iQ3yj3RZ96Ffair.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOL         ")))), trim_right(b"Seed of Life                    "), trim_right(x"5468652053656564206f66204c6966652069732061207361637265642067656f6d657472792073796d626f6c20726570726573656e74696e67206372656174696f6e20616e6420696e746572636f6e6e65637465646e6573732e2049742773206f6674656e207365656e206173206120626c75657072696e7420666f7220616c6c206c6966652c2077697468206561636820636972636c652073796d626f6c697a696e67206120737461676520696e207468652063726561746976652070726f636573730a0a4c61756e63686564206f6e206c657473706c6179666169722c2074686520666972737420416e74692d736e697065722c20416e74692d72756720706c6174666f726d207468617420706179732063726561746f727320746f20686f6c642020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v4);
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

