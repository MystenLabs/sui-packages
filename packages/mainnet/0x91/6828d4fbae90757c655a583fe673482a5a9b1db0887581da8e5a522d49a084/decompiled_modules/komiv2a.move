module 0x916828d4fbae90757c655a583fe673482a5a9b1db0887581da8e5a522d49a084::komiv2a {
    struct KOMIV2A has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMIV2A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c921d260c1effddbb180e8e696831ae68e0bed3f0b558168cdfe30431d4541ea                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KOMIV2A>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KOMIv2      ")))), trim_right(b"KOMIv2                          "), trim_right(x"426f726e2066726f6d20657870657269656e63652c2072656275696c74207769746820707572706f736520204b4f4d49763220726570726573656e7473206120667265736820737461727420666f7220746865204b4f4d4920636f6d6d756e6974792e0a4e6f204655442e204e6f20727567732e204a75737420706f73697469766974792c207472616e73706172656e63792c20616e64207075726520636f6d6d756e69747920706f7765722e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMIV2A>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMIV2A>>(v4);
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

