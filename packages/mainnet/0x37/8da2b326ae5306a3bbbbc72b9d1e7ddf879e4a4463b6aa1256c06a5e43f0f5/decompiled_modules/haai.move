module 0x378da2b326ae5306a3bbbbc72b9d1e7ddf879e4a4463b6aa1256c06a5e43f0f5::haai {
    struct HAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FDaMiK9EEqhs6RZj63YSbs4ELrafgsCsuZ1j5ZZvbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HAAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HAAI        ")))), trim_right(b"HAGAMEAI                        "), trim_right(b"HAGAMEAI is a training framework for AI game evolution. By building diverse game scenario components, ranging from strategic confrontation to simulation, it enhances AI's learning mechanisms, decision-making processes, and its ability to collaborate or compete in complex environments, providing fundamental AI support f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAAI>>(v4);
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

