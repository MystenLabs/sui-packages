module 0x88795e2e147fe8ada47ef8a9162bf2f40f48daa53823becef03cecc1c47b9a74::tmbl {
    struct TMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMBL>(arg0, 9, b"TMBL", b"TEAM BULL", b"Team for the Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b021a526-d4b1-49a9-ae8b-136cd95a926a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

