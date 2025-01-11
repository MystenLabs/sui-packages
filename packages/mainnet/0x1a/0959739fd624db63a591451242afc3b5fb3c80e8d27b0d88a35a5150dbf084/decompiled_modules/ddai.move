module 0x1a0959739fd624db63a591451242afc3b5fb3c80e8d27b0d88a35a5150dbf084::ddai {
    struct DDAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DDAI>, arg1: 0x2::coin::Coin<DDAI>) {
        0x2::coin::burn<DDAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DDAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DDAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BQneN5WDpGq56e4Rav6NaBqis9TPskmKMD39m7LJpump.png?size=lg&key=42a1ec                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DDAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DDAI      ")))), trim_right(b"DONT DIE AI                     "), trim_right(b"Dont Die AI is the first posthuman AI health platform on Solana. In the singularity, only the strongest will survive. Dark Bryan is an AI agent who will act as your personal guide to the esoteric bio hacking secrets of dark angelic accelerationism.                                                                        "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DDAI>>(v5);
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

