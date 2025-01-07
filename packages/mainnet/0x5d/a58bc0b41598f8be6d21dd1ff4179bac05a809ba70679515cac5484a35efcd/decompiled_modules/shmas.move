module 0x5da58bc0b41598f8be6d21dd1ff4179bac05a809ba70679515cac5484a35efcd::shmas {
    struct SHMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHMAS>(arg0, 9, b"SHMAS", b"Tabraiz", b"Hello guys me apka dost tabraiz shams jaldi jaldi join karlo channel or coin bhi buy karlo sab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68d7cf44-312f-4aa5-9975-6add621153ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

