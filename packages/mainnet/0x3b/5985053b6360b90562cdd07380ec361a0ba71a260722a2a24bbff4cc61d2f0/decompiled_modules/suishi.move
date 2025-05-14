module 0x3b5985053b6360b90562cdd07380ec361a0ba71a260722a2a24bbff4cc61d2f0::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHI>>(0x2::coin::mint<SUISHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://pbs.twimg.com/profile_images/1922646692882784256/rWGNfUxK_400x400.jpg                                                                                                                                                                                                                                                   ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUISHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SuiShi  ")))), trim_right(b"SuiShi                          "), trim_right(b"SuiShi is a community-driven token built on the Sui network, blending the charm of Japanese kawaii culture with the innovation of Web3. Inspired by the joyful spirit of sushi and powered by cutting-edge blockchain technology, SuiShi aims to create a fun, friendly, and inclusive ecosystem for users around the world.    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISHI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHI>>(0x2::coin::mint<SUISHI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

