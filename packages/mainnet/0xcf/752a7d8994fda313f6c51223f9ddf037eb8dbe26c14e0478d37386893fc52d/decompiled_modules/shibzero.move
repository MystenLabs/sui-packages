module 0xcf752a7d8994fda313f6c51223f9ddf037eb8dbe26c14e0478d37386893fc52d::shibzero {
    struct SHIBZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"lFadoOv1ox4yhTjF                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHIBZERO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHIBZERO    ")))), trim_right(b"SHIBZERO                        "), trim_right(x"20534849425a45524f20697320746865206e65787420626967206d656d6520636f696e20746f2074616b65206f766572207468652063727970746f20776f726c642120496e7370697265642062792074686520696379206d69676874206f66205375622d5a65726f2066726f6d204d6f7274616c204b6f6d6261742c2062757420776974682061207477697374206f6620536869626120496e752066756e2c20534849425a45524f206973206865726520746f20667265657a652074686520636f6d7065746974696f6e20616e64206272696e6720746865206865617420696e20746865206d656d6520636f696e2073706163652e0d0a0d0a205768617420697320534849425a45524f3f20534849425a45524f20636f6d62696e6573207468652066696572636520706f776572206f6620612077617272696f722077697468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBZERO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBZERO>>(v4);
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

