module 0x1cae9e4c7dd8a7b0ab5eada5ece7b141c0d5dce3748e22687d1ec6a2437fd311::abyss {
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

