module 0x6034947712f9df382c77cadc7dcfac14ebbc15a3efe1180fc65d4c10dcd9bf3b::bnky14 {
    struct BNKY14 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNKY14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNKY14>(arg0, 9, b"BNKY14", b"BONKY", b"Silly, playful,clumsy funny meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2dc1e66-f0b4-443e-80d6-c6f6c1548bd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNKY14>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNKY14>>(v1);
    }

    // decompiled from Move bytecode v6
}

