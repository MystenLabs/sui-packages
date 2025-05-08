module 0x95aea1a5c51fde20f2cb194937c9eef13e23c3dc0eecf60e374b385d226f5e77::senai {
    struct SENAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SENAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SENAI>>(0x2::coin::mint<SENAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/84L8Jut8YiogENrQGgq8SwBNzjtuxZZXz3GMeLbNquV1.png?size=lg&key=dca22f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SENAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SENAI   ")))), trim_right(b"Sentinel AI                     "), trim_right(b"A real-time, AI-driven on-chain security layer that continuously monitors blockchain activity to detect and neutralize scams, rug pulls, and malicious contract behavior  ensuring proactive protection and trust across Web3 ecosystems.                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SENAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SENAI>>(0x2::coin::mint<SENAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

