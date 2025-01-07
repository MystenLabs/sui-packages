module 0x92837bceb09e1ac58a37324865186d3f3f095289395c7453c43fb1020f77223b::fnc {
    struct FNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNC>(arg0, 9, b"FNC", b"KONGz", b"The king came to visit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84a51461-7676-48f3-b3b6-72d183b0c52e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

