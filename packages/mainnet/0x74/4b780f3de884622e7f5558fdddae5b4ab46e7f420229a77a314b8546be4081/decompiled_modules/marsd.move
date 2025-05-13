module 0x744b780f3de884622e7f5558fdddae5b4ab46e7f420229a77a314b8546be4081::marsd {
    struct MARSD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MARSD>>(0x2::coin::mint<MARSD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MARSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://i.ibb.co/s9FBDCGY/1c0e09cf-a08a-4c1e-bfd8-74423e12e46d.jpg                                                                                                                                                                                                                                                              ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MARSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MarsD   ")))), trim_right(b"MarsDoge                        "), trim_right(b"MarsD is the ultimate memecoin for space enthusiasts and crypto explorers alike. Drawing inspiration from the iconic Doge meme, MarsD takes you on an exciting journey to Mars and beyond.                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARSD>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MARSD>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MARSD>>(0x2::coin::mint<MARSD>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

