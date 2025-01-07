module 0x29bad97304756d5b2841fccbfa249e70aa58f99e292f7042f64e0176655a008c::meoww {
    struct MEOWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWW>(arg0, 9, b"MEOWW", b"MEWINGGG", b"MEOW IS MY BOSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75e3188c-9b74-49e5-9b8f-da5f6c3bfd6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

