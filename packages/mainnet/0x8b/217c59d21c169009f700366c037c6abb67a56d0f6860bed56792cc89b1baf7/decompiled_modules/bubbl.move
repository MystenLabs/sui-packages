module 0x8b217c59d21c169009f700366c037c6abb67a56d0f6860bed56792cc89b1baf7::bubbl {
    struct BUBBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBL>(arg0, 6, b"Bubbl", b"Bubl", b"Bubbling on @SuiNetwork to make frens! BUBBLE IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731334732146.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

