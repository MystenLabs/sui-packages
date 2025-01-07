module 0x13ec3b6ceb667a1d17949f1a60ca858fd3e0b4e64d138916d2b7f7d23ac1279f::bashira {
    struct BASHIRA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BASHIRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASHIRA>>(0x2::coin::mint<BASHIRA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BASHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DqByP7Wfm1VHAVNbJo4LbCrpsyicJF1Yr9LVfuaTpump.png?size=lg&key=07e916                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BASHIRA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BASHIRA ")))), trim_right(b"Bashira                         "), trim_right(b"BASHIRA is a meme token featuring a gentle and calm Japanese girl with a casual, simple yet elegant style. Her character embodies tranquility and peace, acting as a soothing presence filled with warmth and kindness. Bashira brings positive vibes, always ready to offer support and comfort as a caring friend.            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASHIRA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BASHIRA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BASHIRA>>(0x2::coin::mint<BASHIRA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

