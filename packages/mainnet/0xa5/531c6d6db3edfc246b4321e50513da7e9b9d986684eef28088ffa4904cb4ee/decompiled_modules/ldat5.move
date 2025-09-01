module 0xa5531c6d6db3edfc246b4321e50513da7e9b9d986684eef28088ffa4904cb4ee::ldat5 {
    struct LDAT5 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT5>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeihu26qlp6h33c53khp64ag56svcvzcqmaof3by7utu42v5hxm5xwi";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeihu26qlp6h33c53khp64ag56svcvzcqmaof3by7utu42v5hxm5xwi"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT5>(arg0, 9, b"LDAT5", b"LDAT5", b"Dont buy, this is a test token. Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT5>>(0x2::coin::mint<LDAT5>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT5>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT5>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT5>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

