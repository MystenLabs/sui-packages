module 0x6e8640b93198125e2a288f66900187ad3045b8b544ba09af7788634658c0f56c::sukablyat {
    struct SUKABLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKABLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKABLYAT>(arg0, 9, b"SUKABLYAT", b"Pidaras", x"d0af20d182d0b2d0bed0b920d180d0bed18220d0b2d18bd0b9d0b1d18320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba550529-8724-48f0-942c-86d16211b843.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKABLYAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKABLYAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

