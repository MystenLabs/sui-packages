module 0x24930705ffb82336b649859a1325e5d9f4314c3c316529febb47a731f1986701::muni {
    struct MUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/46G7oLvmYBJvjYonTtt2HLNMnCMnW8DXatbViisqrxKL.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUNI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"muni        ")))), trim_right(b"muni                            "), trim_right(b"Muni isnt just a coin, its a lifestyle. You could buy a coffee with it, but why would you when you can flex your Muni stash and confuse your friends? This coin was made for the brave, the bold, and the completely unpredictable. Its got zero utility but infinite potential (if by potential you mean making your wallet loo"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNI>>(v4);
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

