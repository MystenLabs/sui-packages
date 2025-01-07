module 0xebc14bba1b9a1b21aa0ba064a13a3d1f5533af3044473b2819a8b5c92bc97758::anct {
    struct ANCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCT>(arg0, 9, b"ANCT", b"ANCHIENT", b"A TOKEN CAME FROM BEFORE OF HISTORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6ac2fdf-5b52-408f-b3a2-14148a190e92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

