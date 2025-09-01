module 0xbca85e60470b2f84e0dad3c3eafe4665ddfd868414bb749ad4237c7ffe7399ed::ldat6 {
    struct LDAT6 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT6>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreifvic72nkpbqlkri7oijfgnaa4lq24buuzsnhdlaq2b3gjsaci4fu";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifvic72nkpbqlkri7oijfgnaa4lq24buuzsnhdlaq2b3gjsaci4fu"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT6>(arg0, 9, b"LDAT6", b"LDAT6", b"dont buy Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT6>>(0x2::coin::mint<LDAT6>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT6>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT6>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT6>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

