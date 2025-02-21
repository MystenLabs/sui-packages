module 0x955201ed82f033cba8682c194eb092e327782f0ae5ccb745aaf16454a97ed347::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2eHJxZyLPxMwyD1jh51vyXa9RNK547BbT4czQdjopump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZEUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZEUS        ")))), trim_right(b"Zeus                            "), trim_right(b"Zeus is a delightful character in the whimsical world of Pepe the Frog. He is inspired by the talented artist Matt Furie. Zeus is no ordinary canine. He serves as Matts alter ego within the Pepe universe, embodying Matts unique perspective on life. As Pepes dog and sidekick, he stands out with his one of a kind earring"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v4);
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

