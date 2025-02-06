module 0xa11e78ad96388c75bfd0aee2b871f7bd7c0a273839afe47efa441c374b3d0d67::bera {
    struct BERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"RhuZlXY6WN2-FmT_                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BERA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bera        ")))), trim_right(b"Babybera                        "), trim_right(x"204261627942657261202054686520546f6b656e2054686174205361766573204265617273200d0a0d0a42656172732061726520646973617070656172696e672e20546865697220666f7265737473206172652076616e697368696e672e20506f616368696e6720616e6420636c696d617465206368616e6765206172652070757368696e67207468656d20746f20657874696e6374696f6e2e204261627942657261206973207468656972206c617374207374616e642e200d0a204576657279207472616e73616374696f6e207361766573207265616c2062656172730d0a20426c6f636b636861696e2d6261636b6564207472616e73706172656e637920204275696c74206f6e20536f6c616e610d0a204e6f20656d7074792070726f6d697365732e204e6f206e6f6973652e204a757374207265616c20696d70616374"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERA>>(v4);
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

