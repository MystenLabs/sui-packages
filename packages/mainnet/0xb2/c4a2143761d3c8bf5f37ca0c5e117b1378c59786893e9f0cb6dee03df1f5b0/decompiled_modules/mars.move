module 0xb2c4a2143761d3c8bf5f37ca0c5e117b1378c59786893e9f0cb6dee03df1f5b0::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"87de07eb67ac049299bffba7059db5193e1fb47231b358e6cd273c277d9e7a26                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MARS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MARS        ")))), trim_right(b"Mars                            "), trim_right(b"On June 26, Posie and Pluto welcomed a healthy baby boy weighing 13 pounds at Tanganyika Wildlife Park in Kansas. The Mars community has donated over $5k USD and is largely responsible for him being named, Mars! 100% of creator rewards are donated to Tanganyika Wildlife Park in support of conservation worldwide.       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v4);
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

