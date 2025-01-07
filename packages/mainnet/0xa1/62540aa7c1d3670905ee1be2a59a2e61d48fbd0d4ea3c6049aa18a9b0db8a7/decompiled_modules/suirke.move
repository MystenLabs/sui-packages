module 0xa162540aa7c1d3670905ee1be2a59a2e61d48fbd0d4ea3c6049aa18a9b0db8a7::suirke {
    struct SUIRKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRKE>(arg0, 6, b"SUIRKE", b"Suirke", b"Hi, I'm SUIRKE, want to be friends? I promise i won't bite, unless you sell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_07_T234733_441_342412eae5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

