module 0xfb515a4fed4d1ba6db070c921af1dabb3581c8e3d0fc692ec1254d12e0e041fe::jamesa {
    struct JAMESA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMESA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ek7C5TYZYTKgGRAFu5L4jckihxRSERDSDxvtdiMtpump.png?claimId=_QTb8mHG9h2L5Mcr                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JAMESA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"James       ")))), trim_right(b"James                           "), trim_right(b"James Harrison, aka The \"Golden Arm\", Dedicated his life to saving babies. He possessed a rare type of blood that produced antibodies that were needed for millions of newborn babies to survive. He actively started donating plasma at 18 years old and didn't stop until he was 80. He never missed a donation appointment. O"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMESA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMESA>>(v4);
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

