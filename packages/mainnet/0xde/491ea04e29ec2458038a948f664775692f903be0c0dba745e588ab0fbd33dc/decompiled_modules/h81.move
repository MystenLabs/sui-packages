module 0xde491ea04e29ec2458038a948f664775692f903be0c0dba745e588ab0fbd33dc::h81 {
    struct H81 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H81, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmcjBTnB6Sj9ewsjjGJjpZWx6FvMc4K8YWh6ZzvCQgWjue                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<H81>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"H81     ")))), trim_right(b"Harnic81                        "), trim_right(x"4861726e696338312028483831292069732061206469676974616c206c656761637920746f6b656e20666f756e64656420627920486172727920616e64204e69636b6f6c652047616c76616e2d4a656e6b696e732e0a0a0a0a45737461626c697368656420696e203230323320616e64206275696c74206f6e207468652053756920626c6f636b636861696e2c204861726e6963383120726570726573656e7473206f776e6572736869702c206c6561726e696e672c2066616d696c792c20616e64206c6f6e672d7465726d2067726f7774682e0a0a0a0a466978656420537570706c793a203831302c303030204838310a0a0a0a4c6561726e2e204275696c642e204f776e2e2050726573657276652e205061737320466f72776172642e202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H81>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H81>>(v4);
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

