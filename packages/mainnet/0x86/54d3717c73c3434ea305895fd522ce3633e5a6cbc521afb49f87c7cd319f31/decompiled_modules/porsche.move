module 0x8654d3717c73c3434ea305895fd522ce3633e5a6cbc521afb49f87c7cd319f31::porsche {
    struct PORSCHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORSCHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORSCHE>(arg0, 6, b"PORSCHE", b"Porsche 911 Turbo", b"Have you ever dreamed about a Porsche?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973303374.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORSCHE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORSCHE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

