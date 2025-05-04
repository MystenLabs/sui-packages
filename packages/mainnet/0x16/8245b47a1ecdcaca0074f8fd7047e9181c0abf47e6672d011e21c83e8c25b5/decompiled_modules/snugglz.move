module 0x168245b47a1ecdcaca0074f8fd7047e9181c0abf47e6672d011e21c83e8c25b5::snugglz {
    struct SNUGGLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUGGLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUGGLZ>(arg0, 9, b"SNUGS", b"Snugglz", b"Because your portfolio just wants a hug.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie5qkx6ouh6ujaotws5dh4ph7kywr5spf5ilruaetlg3b7s6s3mzu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNUGGLZ>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUGGLZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUGGLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

