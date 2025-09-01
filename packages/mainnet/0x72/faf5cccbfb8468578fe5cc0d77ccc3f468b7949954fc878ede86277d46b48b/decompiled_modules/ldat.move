module 0x72faf5cccbfb8468578fe5cc0d77ccc3f468b7949954fc878ede86277d46b48b::ldat {
    struct LDAT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeidyhu6mzl3iysplnlp5wbccnqsydobanwrimgpyubdj3ubcdtfijm";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeidyhu6mzl3iysplnlp5wbccnqsydobanwrimgpyubdj3ubcdtfijm"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT>(arg0, 9, b"LDAT", b"LDAT", b"MLDAT Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT>>(0x2::coin::mint<LDAT>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

