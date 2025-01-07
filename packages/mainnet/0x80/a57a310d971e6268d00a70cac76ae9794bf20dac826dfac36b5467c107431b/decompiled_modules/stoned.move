module 0x80a57a310d971e6268d00a70cac76ae9794bf20dac826dfac36b5467c107431b::stoned {
    struct STONED has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONED>(arg0, 9, b"STONED", b"STN", b"never going home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2b1939e-bfb4-401f-b3a0-7378d72237ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONED>>(v1);
    }

    // decompiled from Move bytecode v6
}

