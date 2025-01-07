module 0xa55dee897f64ff33552f16832cacc390488bb888c147b5c6ce6bd22a079a9fb0::wade {
    struct WADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADE>(arg0, 9, b"WADE", b"WAKE", b"This is a new coin. A funny coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b3976ba-94d0-4c7c-8f40-b626239d3923.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

