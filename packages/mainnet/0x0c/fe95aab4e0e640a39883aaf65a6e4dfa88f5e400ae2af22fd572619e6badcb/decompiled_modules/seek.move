module 0xcfe95aab4e0e640a39883aaf65a6e4dfa88f5e400ae2af22fd572619e6badcb::seek {
    struct SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEK>(arg0, 6, b"SEEK", b"DEEP SEEK AGENT", b"Deep Seek AI is an advanced intelligence agent designed to analyze trends, provide market insights, and optimize decision-making for users. It streamlines data for smarter investments and fosters innovation within the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deepseeklogo_cd4a2efdc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

