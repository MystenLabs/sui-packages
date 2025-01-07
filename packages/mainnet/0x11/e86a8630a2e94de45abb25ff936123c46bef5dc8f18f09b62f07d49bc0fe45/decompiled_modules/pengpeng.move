module 0x11e86a8630a2e94de45abb25ff936123c46bef5dc8f18f09b62f07d49bc0fe45::pengpeng {
    struct PENGPENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PENGPENG>, arg1: 0x2::coin::Coin<PENGPENG>) {
        0x2::coin::burn<PENGPENG>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PENGPENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PENGPENG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PENGPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://static.wixstatic.com/media/3867bb_d7ea69c859414988a2a241215d9e7d05~mv2.png/v1/crop/x_0,y_764,w_1170,h_1072/fill/w_496,h_456,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/3867bb_d7ea69c859414988a2a241215d9e7d05~mv2.png                                                                                          ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PENGPENG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PENGPENG  ")))), trim_right(b"Chinese Pengu                   "), trim_right(b"Just chinese version of Pengu                                                                                                                                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGPENG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PENGPENG>>(v5);
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

