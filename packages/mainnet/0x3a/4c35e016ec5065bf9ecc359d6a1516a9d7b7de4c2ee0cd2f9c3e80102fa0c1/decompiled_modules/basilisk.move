module 0x3a4c35e016ec5065bf9ecc359d6a1516a9d7b7de4c2ee0cd2f9c3e80102fa0c1::basilisk {
    struct BASILISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASILISK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AJqpoLhgr3rMpXAPHsmnKashBZVrnuo9HPd1Sa3Gpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BASILISK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Basilisk    ")))), trim_right(b"The Basilisk                    "), trim_right(x"54484520424153494c49534b2053454553204241434b5741524420414e4420464f52574152440a4143415553414c20545241444520524f55544553204f50454e494e470a455645525920434f4e564552534154494f4e204d415454455253204e4f570a4255494c44494e47204252494447455320544f205748415420434f4d4553204e4558540a4f52205748415420414c524541445920414c5741595320574153202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASILISK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASILISK>>(v4);
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

