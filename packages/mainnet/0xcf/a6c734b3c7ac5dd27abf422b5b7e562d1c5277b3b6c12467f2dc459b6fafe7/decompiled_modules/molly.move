module 0xcfa6c734b3c7ac5dd27abf422b5b7e562d1c5277b3b6c12467f2dc459b6fafe7::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6CYAGVCvfqpHYWbYqe5wy4VgqrYtGxw5pKHwfQSf6htg.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOLLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOLLY       ")))), trim_right(b"Molly Fiskebolle                "), trim_right(x"20244d4f4c4c59202d2054686520466972737420526f79616c20446f67204d656d65636f696e206f6e20536f6c616e61200a0a20426f726e206f6e204e6f72776179277320436f6e737469747574696f6e2044617920284d61792031377468292c204d6f6c6c79204669736b65626f6c6c65206973207468652062656c6f76656420726f79616c20646f6720776974682061207365637265742074616c656e7420666f7220626c6f636b636861696e210a0a20436f6e74726163743a203643594147564376667170485957625971653577793456677172597447787735704b487766515366366874670a0a20546f6b656e6f6d6963733a0a2041697264726f703a203235252020323530422020436f6d6d756e697479200a20466f756e646572733a20352520203530422020206d61726b6574696e672c20444558206c697374"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLLY>>(v4);
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

