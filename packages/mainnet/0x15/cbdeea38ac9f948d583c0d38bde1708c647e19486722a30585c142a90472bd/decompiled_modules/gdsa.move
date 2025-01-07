module 0x15cbdeea38ac9f948d583c0d38bde1708c647e19486722a30585c142a90472bd::gdsa {
    struct GDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSA>(arg0, 9, b"GDSA", b"SADF", b"GRF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c0b825f-71bb-4dfe-a922-61c2393c6d0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

