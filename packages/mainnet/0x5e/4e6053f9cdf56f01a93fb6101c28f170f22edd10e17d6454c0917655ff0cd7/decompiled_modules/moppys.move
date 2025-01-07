module 0x5e4e6053f9cdf56f01a93fb6101c28f170f22edd10e17d6454c0917655ff0cd7::moppys {
    struct MOPPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPPYS>(arg0, 6, b"MOPPYS", b"MOPPY", b"LETS CTO THIS DEV IS RETARDED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TESTTT_bac3393185.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOPPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

