module 0x15bfdd64f1e6b465d6c968f932e12f25cd23bb1ce87c0b9a686c9b29768e5e95::keifi {
    struct KEIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEIFI>(arg0, 6, b"KEIFI", b"Keifi The Kat", b"The Official Meme Coin For \"The Keiths\" NFT Project. The Keiths emblem embodies the spirit of resilience and unity. $KEIFI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Mdu_Fd_Sz_400x400_33f7714916.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

