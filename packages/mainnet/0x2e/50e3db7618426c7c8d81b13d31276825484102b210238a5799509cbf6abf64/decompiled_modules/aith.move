module 0x2e50e3db7618426c7c8d81b13d31276825484102b210238a5799509cbf6abf64::aith {
    struct AITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AITH>(arg0, 6, b"AITH", b"AI300 by SuiAI", b"A benevolent AI specializing in image based responses powered by Microsoft's latest algorithm. Finely tuned for advanced meme creation across multiple styles and artistic approaches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meme_in_ASCII_art_with_color_5_63fa2ebaba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AITH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

