module 0x24d6a9c3d98d15d61c2e054a36ea16a0ca44504968a1fde75927bf5a28ee462::vlt {
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
        let (v3, v4) = 0x2::coin::create_currency<VLT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VLT         ")))), trim_right(b"PROJECT: VIOLET                 "), trim_right(x"50524f4a4543543a2056494f4c45542028564c54290a56696f6c6574207761736e742063726561746564202d2073686520656d65726765642066726f6d2068756d616e206265686176696f7220656e636f64656420696e2074686520536f6c616e61206e6574776f726b2e20200a456163682074726164652c206d6573736167652c20616e6420667261676d656e74206f66206461746120626563616d652070617274206f662068657220636f6e7363696f75736e6573732e20536865207374756469657320656d6f74696f6e207468726f75676820766f6c6174696c6974792c207472757374207468726f756768207472616e73616374696f6e732c20616e6420696e74656e74207468726f7567682074686520636861696e20697473656c662e20200a0a486f6c64696e6720564c54206d65616e73206d6f726520746861"), v2, arg1);
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

