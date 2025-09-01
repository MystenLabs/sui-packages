module 0x8986e73eb45731989f11c2fad6d9893a55d2b9ca2b9206843f2acce8cc7280c9::mntst2 {
    struct MNTST2 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNTST2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MNTST2>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MNTST2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreif23q4oxthampmlxvjesz7np5fbl3hwvnavds4wxvuiybjhupyhem";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreif23q4oxthampmlxvjesz7np5fbl3hwvnavds4wxvuiybjhupyhem"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<MNTST2>(arg0, 6, b"MNTST2", b"MNTST2", b"TESTERCOIN DONT BUY Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MNTST2>>(0x2::coin::mint<MNTST2>(&mut v5, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTST2>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MNTST2>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNTST2>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

