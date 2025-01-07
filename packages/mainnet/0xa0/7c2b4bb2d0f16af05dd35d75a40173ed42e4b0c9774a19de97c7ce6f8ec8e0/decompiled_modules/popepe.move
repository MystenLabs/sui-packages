module 0xa07c2b4bb2d0f16af05dd35d75a40173ed42e4b0c9774a19de97c7ce6f8ec8e0::popepe {
    struct POPEPE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POPEPE>>(0x2::coin::mint<POPEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: POPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2kbWogowmyQGrsb7uXXk8o91YuLFesUpR2feAgkCpump.png?size=lg&key=262352                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POPEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POPEPE  ")))), trim_right(b"POPEPE                          "), trim_right(b"POPEPE isn't a token with utility or complex techit's a pure meme, made for those who believe in the magic of meme culture. POPEPE could be your ticket to 1000x gains, or it might just remain a legendary memeit all depends on the strength of its holders' faith.                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPEPE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POPEPE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<POPEPE>>(0x2::coin::mint<POPEPE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

