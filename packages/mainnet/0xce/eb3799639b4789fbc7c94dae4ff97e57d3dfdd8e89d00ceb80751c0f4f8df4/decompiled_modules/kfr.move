module 0xceeb3799639b4789fbc7c94dae4ff97e57d3dfdd8e89d00ceb80751c0f4f8df4::kfr {
    struct KFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"zyZXoW2j9ahMN_tT                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KFR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KFR         ")))), trim_right(b"Keefer Bunny                    "), trim_right(b"With Easter falling on 4/20 this year, someone special is coming to town. Known as the Keefer Bunny among his fans, hes a folk hero for the laid-back. His wicker basket filled with eggs to rewards his token holders. This furry gentleman has one main goal. To bring good vibes and legitimacy to meme coins across the land"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFR>>(v4);
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

