module 0x4a39a63457c7f8072271d764d977b9ebb1382f12f249a48ed65880b27cf1ff63::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FRED>>(0x2::coin::mint<FRED>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CNvitvFnSM5ed6K28RUNSaAjqqz5tX1rA5HgaBN9pump.png?size=lg&key=a6512b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRED>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRED    ")))), trim_right(b"First Convicted RACCON          "), trim_right(b"The First Convicted RACCON \" A New York man who turned a rescued squirrel into a social media star called Peanut is pleading with state authorities to return his beloved pet after they seized it during a raid that also yielded a raccoon named Fred.                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRED>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRED>>(0x2::coin::mint<FRED>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

