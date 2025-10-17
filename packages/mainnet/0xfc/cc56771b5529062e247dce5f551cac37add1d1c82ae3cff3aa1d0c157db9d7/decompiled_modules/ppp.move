module 0xfccc56771b5529062e247dce5f551cac37add1d1c82ae3cff3aa1d0c157db9d7::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"709159af5a4b9517131d8ac2a2168aada7df88f5477298484afe8c09336a0c4e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PPP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PPP         ")))), trim_right(b"PLAYER PUMP PLAYER              "), trim_right(x"504c415945522050554d5020504c415945522028505050292069732074686520756c74696d61746520766973696f6e206f66204a555020466f756e646572204d656f7720666f722063727970746f2e200a0a5468726f75676820505050206d61737365732077696c6c206265206f6e626f617264656420696e746f204a55504954455220616e64204a55504954455220616666696c69617465642070726f746f636f6c7320696e20612066756e2c20696e6e6f7661746976652066617368696f6e2e204a0a4f494e2054484953204558434954494e47204d495353494f4e20696e746f205552414e5553207768657265206576657279206361746465742077696e732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPP>>(v4);
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

