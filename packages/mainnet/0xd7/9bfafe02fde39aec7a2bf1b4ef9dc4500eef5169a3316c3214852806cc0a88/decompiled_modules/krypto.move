module 0xd79bfafe02fde39aec7a2bf1b4ef9dc4500eef5169a3316c3214852806cc0a88::krypto {
    struct KRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FHc1Dg4z6hpoB4kBefGZU9spRKBW8gexpjEhMSJ9pump.png?claimId=OCB0wZdXwTcVlZPn                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KRYPTO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KRYPTO      ")))), trim_right(b"Superman's Dog                  "), trim_right(b"Krypto - an unstoppable force inspired by Ozu, the real-life Krypto dog from James Gunn's Superman and featured in the new Superman movie. Krypto is more than a character; hes a symbol of hope, reminding us that no dog should die, not even one. Every year, 390,000 dogs in the US and countless more worldwide are euthani"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRYPTO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRYPTO>>(v4);
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

