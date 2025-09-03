module 0x8b20d31a6f9caf4e983763a36205d4e2630f67057daa85c50a0af898fa797fd9::mnnttst {
    struct MNNTTST has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNNTTST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MNNTTST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MNNTTST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeigofj3augcigj6e3boql527byjfdzlcthpgd4txsd4i5wiw7wvrry";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeigofj3augcigj6e3boql527byjfdzlcthpgd4txsd4i5wiw7wvrry"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MNNTTST>(arg0, 9, b"MNNTTST", b"MNNNTTST", b"DONT BUY Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MNNTTST>>(0x2::coin::mint<MNNTTST>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNNTTST>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MNNTTST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNNTTST>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

