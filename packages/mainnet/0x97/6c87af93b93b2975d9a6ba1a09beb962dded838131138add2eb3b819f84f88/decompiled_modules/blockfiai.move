module 0x976c87af93b93b2975d9a6ba1a09beb962dded838131138add2eb3b819f84f88::blockfiai {
    struct BLOCKFIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKFIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKFIAI>(arg0, 9, b"BFI", b"BlockFi-Ai", b"BlockFi-Ai - AI-powered financial services on the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihr5h5rycsxrpqxs7ddoreq6g2uiry6hscq2xgiacejrs2htk3a2a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOCKFIAI>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKFIAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOCKFIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

