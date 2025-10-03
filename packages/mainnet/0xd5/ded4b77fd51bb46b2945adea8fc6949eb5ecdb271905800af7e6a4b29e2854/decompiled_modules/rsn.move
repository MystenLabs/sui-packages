module 0xd5ded4b77fd51bb46b2945adea8fc6949eb5ecdb271905800af7e6a4b29e2854::rsn {
    struct RSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"0de479f254b9aecdd978695f8d42f1ec02316bb77d9b2660db02ebbc265175a5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RSN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RSN         ")))), trim_right(b"Resonate                        "), trim_right(x"5265736f6e6174653a204964656173207468617420636f6e6e6563742e0a0a466f726765742074686520646f67732c2066726f67732c20616e6420686174732e20497427732074696d6520666f722061206d656d65207769746820612047696761427261696e2e0a0a5265736f6e617465202852534e292069732074686520737061726b20666f72206120636f6d6d756e6974792d6275696c7420736f6369616c2077656273697465207769746820616e20414920736f756c2e205765277265206275696c64696e672074686520706c61636520776520616c6c2077616e7420746f2068616e67206f757477686572652074686520616c70686120697320736d6172742c2074686520636f6e766572736174696f6e7320617265207265616c2c20616e642074686520636f6d6d756e6974792076696265732e0a0a5468652052"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSN>>(v4);
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

