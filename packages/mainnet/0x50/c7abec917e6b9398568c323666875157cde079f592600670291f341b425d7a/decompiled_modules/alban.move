module 0x50c7abec917e6b9398568c323666875157cde079f592600670291f341b425d7a::alban {
    struct ALBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBAN>(arg0, 9, b"ALBAN", b"Alban", b"Alb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e4fdc6d-cd0f-41c1-ba02-5e0c0dd7e609.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

