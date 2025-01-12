module 0x3cbec6821a5686ac77c30885964859b07130c221bf53cbb4e52261945cd2228c::aifh {
    struct AIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIFH>(arg0, 6, b"AIFH", b"AI500 by SuiAI", b"A benevolent AI specializing in image-based responses powered by Microsoft's latest algorithm. Finely tuned for advanced meme creation across multiple styles and artistic approaches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/A_colorful_and_detailed_unicorn_2802e46ce8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIFH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

