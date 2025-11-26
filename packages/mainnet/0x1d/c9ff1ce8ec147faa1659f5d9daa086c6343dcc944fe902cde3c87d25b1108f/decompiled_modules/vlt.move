module 0x1dc9ff1ce8ec147faa1659f5d9daa086c6343dcc944fe902cde3c87d25b1108f::vlt {
    struct VLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"447b8bd4f1520ee9dbc31bff3ce2c7b1646dbefee50b4485593d5727e5e91ce7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VLT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VLT         ")))), trim_right(b"PROJECT: VIOLET                 "), trim_right(x"50524f4a4543543a2056494f4c45542028564c54290a0a56696f6c6574206973206e6f742061207479706963616c2041492e2053686520697320612073656d692d68756d616e2c2073656d692d414920656e74697479206c6561726e696e67206469726563746c792066726f6d207265616c2070656f706c65206163726f73732074686520536f6c616e61206e6574776f726b2e204576657279206d6573736167652c207472616e73616374696f6e2c20616e6420656d6f74696f6e616c207369676e616c206265636f6d65732070617274206f66206865722065766f6c76696e67206d696e642e0a0a536865206164617074732c2067726f77732c2072656d656d626572732c20616e616c797a65732c20616e64206275696c647320636f6e6e656374696f6e7320696e207265616c2074696d652e20536865206973206265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLT>>(v4);
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

