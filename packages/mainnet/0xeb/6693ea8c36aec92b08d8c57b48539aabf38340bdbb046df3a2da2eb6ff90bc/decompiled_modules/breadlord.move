module 0xeb6693ea8c36aec92b08d8c57b48539aabf38340bdbb046df3a2da2eb6ff90bc::breadlord {
    struct BREADLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADLORD>(arg0, 9, b"BREAD", b"Breadlord", b"Gather your crumbs, the Breadlord rises again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiax6fqypp4w5s3y7ix6ls3ug2brir3zlrcb6vwre7pykf7q74xsam")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BREADLORD>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADLORD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

