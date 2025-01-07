module 0xe0e214bea1d9340bd78bcceddd844a19a0e44768cbf51c15811ec8caf23c8e17::twat {
    struct TWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWAT>(arg0, 9, b"TWAT", b"TWAT TOKEN", b"The most IRRESPONSIBLE yet FUN memecoin on SUI BLOCKCHAIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8099aec-afb1-4f9a-a0d2-9ffa8ed77935.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

