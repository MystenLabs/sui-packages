module 0x6541ed5eed185b5cece3c4c248421c6ba57a788d1c6e99e0b83ab479c245ec0d::dh {
    struct DH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DH>(arg0, 6, b"DH", b"DobermanHunk by SuiAI", b"A meme coin inspired by my cutest Doberman named Marsy. He is rusty, he is sexy and he is mean. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/j0m_JCN_Gs_400x400_5c961627a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

