module 0xee1f96e7f2802a868aa05930466fb8bde35156166134ea8b999357cae589190c::blrg {
    struct BLRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLRG>(arg0, 9, b"BLRG", b"balrog", b"It is the name of a demon in the Zoroastrian religion that can cover fire with sin, this is a religious belief.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9ef17af-4dc4-4d83-bfd4-aa737552cd8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

