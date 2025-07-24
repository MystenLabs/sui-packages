module 0x4719f290df4e9a3e9df3c5b4c337092144b43e629c20ab349e022046c9e1a6ad::santadrops {
    struct SANTADROPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTADROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"0e0fd57ef48232924f8e3705911cf1fc00a7487cc6a3ee7ec403615f712b9a31                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SANTADROPS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SANTADROPS  ")))), trim_right(b"SANTADROPS                      "), trim_right(x"4445562057494c4c204e4f5420525547205448495320434f494e210a0a204e4f205441582e204e4f205255472e204e4f2050524553414c452e0a416e792072656420666c61677320796f75207365653f2050726f6261626c792066726f6d20796f7572206578206f722061206a65616c6f7573206a6565742e0a546869732061696e74206a7573742061206d656d65636f696e20206974732061207661756c742d706f7765726564207061737369766520696e636f6d65206d616368696e6520696e20612053616e746120737569742e200a0a204461696c7920534f4c2041697264726f70732020546f70203530204c5020686f6c64657273206765742070616964206175746f6d61746963616c6c792c206576657279206461792e0a204275696c74206f6e204d6574656f7261207669612044657873637265656e65722020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTADROPS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTADROPS>>(v4);
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

