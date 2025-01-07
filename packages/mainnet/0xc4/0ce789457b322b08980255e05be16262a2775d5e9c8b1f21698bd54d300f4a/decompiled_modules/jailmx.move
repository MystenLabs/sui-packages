module 0xc40ce789457b322b08980255e05be16262a2775d5e9c8b1f21698bd54d300f4a::jailmx {
    struct JAILMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILMX>(arg0, 9, b"JAILMX", b"Giha", b"Hjjka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98405820-5bf8-446e-85a8-2e61db17863d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAILMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

