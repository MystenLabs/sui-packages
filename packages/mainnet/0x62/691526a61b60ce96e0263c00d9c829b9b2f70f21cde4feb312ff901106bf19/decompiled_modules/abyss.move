module 0x62691526a61b60ce96e0263c00d9c829b9b2f70f21cde4feb312ff901106bf19::abyss {
    struct ABYSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABYSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABYSS>(arg0, 9, b"ABYSS", b"Data Wormhole", b"If you gaze long into an abyss, the abyss will gaze back into you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRs5ZhayYzic7tgCj5WpxXwdgRSCb1vHafNkXqDqywBae")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABYSS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABYSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABYSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

