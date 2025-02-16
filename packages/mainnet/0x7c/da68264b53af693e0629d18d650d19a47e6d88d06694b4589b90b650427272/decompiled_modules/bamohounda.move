module 0x7cda68264b53af693e0629d18d650d19a47e6d88d06694b4589b90b650427272::bamohounda {
    struct BAMOHOUNDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMOHOUNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"iyiiTupQMglBjGnJ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAMOHOUNDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAMOHOUND   ")))), trim_right(b"Bavarian Mountain Hound         "), trim_right(x"426176617269616e204d6f756e7461696e20486f756e6420282442414d4f484f554e442920205468652048756e74696e6720446f67206f66204d656d6520436f696e73210d0a0d0a546865202442414d4f484f554e4420697320696e737069726564206279207468652074686520426176617269616e204d6f756e7461696e20486f756e642c20776974682069747320756e7761766572696e67206c6f79616c74792c206b65656e20696e7374696e6374732c20616e642072656c656e746c6573732064657465726d696e6174696f6e2c206973206e6f74206a75737420612068756e7465727320636f6d70616e696f6e20627574206120747275652073796d626f6c206f6620726573696c69656e636520616e642068656172742e0d0a0d0a546865202442414d4f484f554e44206973206f6e207468652068756e74212054"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMOHOUNDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMOHOUNDA>>(v4);
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

