module 0x56cabce76c96b9a94fa3a6f0d7f9c7ff27b40c7582df1c9684eb1f8c3cbaa525::lensui {
    struct LENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENSUI>(arg0, 6, b"LENSUI", b"LEN SASSAMAN SUI", b"Am I Satoshi Nakamoto? Polymarket and HBO thinks so do you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_at_19_30_38_edcc51185a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

