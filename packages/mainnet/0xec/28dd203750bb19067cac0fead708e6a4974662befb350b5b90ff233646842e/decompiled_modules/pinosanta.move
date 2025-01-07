module 0xec28dd203750bb19067cac0fead708e6a4974662befb350b5b90ff233646842e::pinosanta {
    struct PINOSANTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PINOSANTA>, arg1: 0x2::coin::Coin<PINOSANTA>) {
        0x2::coin::burn<PINOSANTA>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PINOSANTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PINOSANTA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PINOSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3Y6fjhHRV6orAka12ThbiWSVapnroYovoBwzZEqYCECq.png?size=lg&key=8f4227                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PINOSANTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PINOSANTA ")))), trim_right(b"PINO SANTA                      "), trim_right(b"Hey there, festive friends! Its me, Pino Santathe jolliest dino in a Santa hat, here to spread joy, gifts, and dino-sized cheer                                                                                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINOSANTA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PINOSANTA>>(v5);
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

