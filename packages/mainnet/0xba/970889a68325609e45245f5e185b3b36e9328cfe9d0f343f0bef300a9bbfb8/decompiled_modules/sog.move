module 0xba970889a68325609e45245f5e185b3b36e9328cfe9d0f343f0bef300a9bbfb8::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SOG>>(0x2::coin::mint<SOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fpixlr_image_generator_a421eafe_e4d4_4da7_bc33_c35fbe1b23bd_fafd8cc012.png&w=640&q=75                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOG     ")))), trim_right(b"SQUIRREL IN A CLOTH             "), trim_right(b"$SOG Just A Squirrel in a Cloth No socials!! Lets prove u dont need social to be successful all you need to do is buy & hold                                                                                                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SOG>>(0x2::coin::mint<SOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

