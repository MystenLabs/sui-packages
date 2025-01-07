module 0xfcf7ad94e709ffc9cb9a5a584dee8051b8652372a0df9a8b7119591869df7474::isu {
    struct ISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/yz20S_hJrmBQHk5i1oy65fLenlg15NQw1BLT2Z3iB50                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ISU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ISU     ")))), trim_right(b"Iustitia Coin                   "), trim_right(b"IUS is a memecoin launched on the SUI blockchain, symbolizing the essence of justice, fairness, and community-driven fun. Inspired by the mythological creature Iusora, IUS aims to create a decentralized ecosystem where humor meets the pursuit of equality and transparency in the crypto space.                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISU>>(v4);
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

