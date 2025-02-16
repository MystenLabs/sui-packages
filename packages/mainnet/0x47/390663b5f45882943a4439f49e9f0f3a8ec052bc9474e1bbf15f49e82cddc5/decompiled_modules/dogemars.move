module 0x47390663b5f45882943a4439f49e9f0f3a8ec052bc9474e1bbf15f49e82cddc5::dogemars {
    struct DOGEMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"nCzFLs8tf8DH2UTX                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGEMARS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGEMARS    ")))), trim_right(b"DOGE: Mission to Mars           "), trim_right(b"Our journey begins! At the swearing-in ceremony of the 47th President of the United States, Donald Trump, his close associate, the founder of Tesla and SpaceX, Elon Musk, said in his address that he was going to go DOGE to Mars. Do you understand what this means? If you missed the DOGE flight to the Moon, you have a ch"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMARS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEMARS>>(v4);
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

