module 0xab9f63af7b6ae8ae83f67c7f11aa9fb3b1c3fd1314c4b0786f7d1724e843f0f4::upsd {
    struct UPSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"327d6c7ca87e2d82033b11e1cf333384bde298e68d2df62f6ce9cc68edd55713                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UPSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UPSD        ")))), trim_right(b"Upside Down                     "), trim_right(x"426f726e2066726f6d2074686520537472616e676572205468696e677320756e6976657273652c205468652055707369646520446f776e2069732074686520636f696e206275696c7420746f20666c6970207468652063727970746f20776f726c64206261636b206f6e2069747320666565742e0a436c65616e206c61756e63682c20746967687420737570706c7920636f6e74726f6c2c206e6f2067696d6d69636b7320206a757374206120726576657273616c206f6620746865206368616f7320616e6420612070617468206261636b20746f2070726f666974732e0a53746570207468726f7567682074686520706f7274616c2e20436f6d65206261636b207374726f6e6765722e0a24555053442020546865206d61726b657420666c69702073746172747320686572652e2020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPSD>>(v4);
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

