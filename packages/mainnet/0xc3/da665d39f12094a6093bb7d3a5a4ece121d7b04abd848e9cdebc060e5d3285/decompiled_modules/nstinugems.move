module 0xc3da665d39f12094a6093bb7d3a5a4ece121d7b04abd848e9cdebc060e5d3285::nstinugems {
    struct NSTINUGEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSTINUGEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSTINUGEMS>(arg0, 9, b"NSTINUGEMS", b"NSTInu", b"NST meme gems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6bbc2ad-3957-4727-b517-15dad9f301b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSTINUGEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSTINUGEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

