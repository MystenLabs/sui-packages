module 0x1eb5e3aba930dde9489929b045a9d4f3d63334246e6e6bcdfdf9fc6cc34b6e21::grt {
    struct GRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://files.catbox.moe/kjpxot.jpg                                                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRT     ")))), trim_right(b"GRAT                            "), trim_right(x"475241542028475254290a47726f777468202d2057652067726f7720746f676574686572206173206120636f6d6d756e6974792e0a526577617264202d204561726c7920737570706f727465727320616e6420686f6c64657273206172652072657761726465642e0a5472757374202d205765206275696c642077697468207472616e73706172656e637920616e6420686f6e657374792e0a47524154206973206120636f6d6d756e6974792d64726976656e20746f6b656e206f6e20537569206275696c7420666f722066617374207061796d656e74732c207265776172647320616e64207265616c207574696c6974792e20314220666978656420737570706c792c206e6f206d6f7265206d696e74696e672e204275696c742062792074686520636f6d6d756e6974792c20666f722074686520636f6d6d756e6974792e"), v2, arg1);
        let v5 = v3;
        0x2::coin::mint_and_transfer<GRT>(&mut v5, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRT>>(v4);
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

