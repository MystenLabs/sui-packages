module 0x5f32ae281a5e95c369750dd5ab8b9f5ea79d69f962b7b8b26fcd2e92df3ad7ae::jdcoin {
    struct JDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1bee8e1fa97b28d3c9a90e8de577a427790b5ca85381a893a7cdcff64138674f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JDCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JDCOIN      ")))), trim_right(b"Diabetes Cure Donation Flywheel "), trim_right(b"JD COIN isnt just another token,  its a flywheel for hope. Every trade fuels the fight against juvenile diabetes, turning speculation into real-world impact. Were merging meme culture with mission culture,  proving crypto can do more than pump, it can heal.  My son was diagnosed with Type 1 Diabetes at just 7 years old"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JDCOIN>>(v4);
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

