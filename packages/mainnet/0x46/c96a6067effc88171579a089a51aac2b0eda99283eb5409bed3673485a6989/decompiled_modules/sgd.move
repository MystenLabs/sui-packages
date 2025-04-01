module 0x46c96a6067effc88171579a089a51aac2b0eda99283eb5409bed3673485a6989::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://gateway.irys.xyz/0CioVmxSFKHpX0YDdsAha9caiApAC2IT8aiYPjj24Vg                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SGD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SGD     ")))), trim_right(b"Dolar Singapura                 "), trim_right(b"(SGD) ialah mata wang stabil yang dikeluarkan oleh kerajaan Singapura pada rangkaian blockchain.                                                                                                                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v4);
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

