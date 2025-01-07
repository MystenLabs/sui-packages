module 0x92760d326fa7a94c8d4ddde21bd36c9ec56013170a8e9fbc5c6351ade142ad85::rflg {
    struct RFLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFLG>(arg0, 9, b"RFLG", b"REDFLAG", b"red flag means a good trade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c3eba1a-b173-475f-987e-bdac82ce6e7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RFLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

