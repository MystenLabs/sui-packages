module 0x7e2bfd05c3af25996a20f215bd39e1f9f376436f12c4d0b8e25ed074559017ee::gdsa {
    struct GDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSA>(arg0, 9, b"GDSA", b"SADF", b"GRF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d985a860-65bd-4b49-9c50-60e9f8827bd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

