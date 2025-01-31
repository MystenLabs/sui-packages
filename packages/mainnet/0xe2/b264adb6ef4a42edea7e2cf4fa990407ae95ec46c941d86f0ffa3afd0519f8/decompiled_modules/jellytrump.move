module 0xe2b264adb6ef4a42edea7e2cf4fa990407ae95ec46c941d86f0ffa3afd0519f8::jellytrump {
    struct JELLYTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JELLYTRUMP>, arg1: 0x2::coin::Coin<JELLYTRUMP>) {
        0x2::coin::burn<JELLYTRUMP>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<JELLYTRUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JELLYTRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JELLYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/B5CStaXwoV2feKMzxj4wd3hJWQu6ZPAiMXo6b8Eipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JELLYTRUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"jellytrump")))), trim_right(b"jelly-my-trump                  "), trim_right(b"jelly-my-trump                                                                                                                                                                                                                                                                                                                  "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYTRUMP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JELLYTRUMP>>(v5);
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

