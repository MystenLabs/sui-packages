module 0x5526009b8c1ba9e3180a7829e0b3945218ff273243a26e727050fe1a20b44cce::mntst5 {
    struct MNTST5 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNTST5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MNTST5>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MNTST5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeihcrrhqfepqqaqbjl3oeartrxd7tixt3yratcmthnu64uzvxnxkba";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeihcrrhqfepqqaqbjl3oeartrxd7tixt3yratcmthnu64uzvxnxkba"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MNTST5>(arg0, 6, b"MNTST5", b"MNTST5", b"DONT BUY Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MNTST5>>(0x2::coin::mint<MNTST5>(&mut v5, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTST5>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MNTST5>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNTST5>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

