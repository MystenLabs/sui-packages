module 0x96e44eb5114a9166027f6ac583093a2ea5a7f6c17935829ce0fc10e0d12c7416::tass {
    struct TASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"kn6ooRbRG3dbjNXB                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TASS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TASS        ")))), trim_right(b"TIGHT ASS SEASON                "), trim_right(x"54696768742041737320536561736f6e202824544153532920205468652046696c7468792c20556e6375742c20556e63656e736f7265642043727970746f20457870657269656e6365200d0a0d0a4c69676874732e2043616d6572612e20416374696f6e2e2057656c636f6d6520746f2054696768742041737320536561736f6e202824544153532974686520737465616d696573742c20776574746573742c20616e64206d6f737420697272657369737469626c65206d656d6520636f696e20746f206576657220736c69646520696e746f20796f757220706f7274666f6c696f2e20546869732069736e74206a75737420612063727970746f746869732069732066756c6c2d6f6e2066696e616e6369616c20666f7265706c61792e0d0a0d0a205374617272696e673a0d0a20546865205469676874657374204c697175"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASS>>(v4);
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

