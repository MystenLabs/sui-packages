module 0x9b2107aa300e8698a24e66acc19304898b4c5b5a930fb445d897e9531783c130::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAIKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LAIKA>>(0x2::coin::mint<LAIKA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xc05cf430b4a9c4ffeac92bce5fadf958c7a20336.png?size=lg&key=446554                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LAIKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Laika   ")))), trim_right(b"Laika AI                        "), trim_right(b"Analyze. Swap. Innovate. All In One App.   Laika AI - All in One DefAI assistant (10000+ daily active users)   Laika is the first crypto AI assistant to be integrated into ChatGPT   Use Telegram mini-app for your queries   Integrate with Laika API                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAIKA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAIKA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LAIKA>>(0x2::coin::mint<LAIKA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

