module 0x72e788c784c57d1148b07d90c7cb496b3f53b30a90c2aee1aa0b023c353f2129::ldat888 {
    struct LDAT888 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT888>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT888>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT888, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeigcisytsnwmxzpi3jzxt34uipnesqqtg55msosldaw5wxhtmid4oe";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeigcisytsnwmxzpi3jzxt34uipnesqqtg55msosldaw5wxhtmid4oe"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT888>(arg0, 9, b"LDAT888", b"LDAT888", b"Do not buy this token, this is a test token and will never have any actual value past 5 SUI tokens Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT888>>(0x2::coin::mint<LDAT888>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT888>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT888>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT888>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

