module 0xfa2f3f0f97f12c80eaa636f21cb01379dc540dd30067ba021d00c92b4a3cb5a::pnsbs {
    struct PNSBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNSBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNSBS>(arg0, 9, b"PNSBS", b"bdnd", b"ndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0640469d-563e-4c47-96be-fac47f745541.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNSBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNSBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

