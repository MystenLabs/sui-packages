module 0x4d733cd59a8d09efccb5a84a418af6f4742d90038c0931de2d8580bd74875b8b::godsui {
    struct GODSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODSUI>(arg0, 6, b"Godsui", b"Sui God", b"SuiGod aims to build an advanced analytics dashboard for blockchain projects, providing real-time insights, transaction tracking, and performance metrics. Empowering users with data-driven tools to optimize strategies and drive informed decisions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731026065223.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

