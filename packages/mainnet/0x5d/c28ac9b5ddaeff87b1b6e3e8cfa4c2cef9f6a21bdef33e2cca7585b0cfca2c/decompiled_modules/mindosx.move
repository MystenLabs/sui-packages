module 0x5dc28ac9b5ddaeff87b1b6e3e8cfa4c2cef9f6a21bdef33e2cca7585b0cfca2c::mindosx {
    struct MINDOSX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINDOSX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MINDOSX>>(0x2::coin::mint<MINDOSX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MINDOSX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FEZ2g47FzhJcAnEBy94fFvZ8H7ZGnvui7cZFW8oEpump.png?size=lg&key=95e4d4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MINDOSX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MindOSX ")))), trim_right(b"MindOSX                         "), trim_right(b"MindOSX is a new kind of chain: an AI-native Layer 2, purpose-built to support real-time inference, intelligent agent deployment, and on-chain learningall while leveraging Solanas performance and liquidity. This is the first Layer 2 that thinks.                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINDOSX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINDOSX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MINDOSX>>(0x2::coin::mint<MINDOSX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

