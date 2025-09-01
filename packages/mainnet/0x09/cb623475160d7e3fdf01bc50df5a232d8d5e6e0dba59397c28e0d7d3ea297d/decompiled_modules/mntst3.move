module 0x9cb623475160d7e3fdf01bc50df5a232d8d5e6e0dba59397c28e0d7d3ea297d::mntst3 {
    struct MNTST3 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNTST3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MNTST3>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MNTST3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeic3vssjhaufd3mm53afeclmfo7bkjlx5eh7iktyep55v3j3ttppae";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeic3vssjhaufd3mm53afeclmfo7bkjlx5eh7iktyep55v3j3ttppae"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MNTST3>(arg0, 9, b"MNTST3", b"MNTST3", b"Test Coin 3 Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MNTST3>>(0x2::coin::mint<MNTST3>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTST3>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MNTST3>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNTST3>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

