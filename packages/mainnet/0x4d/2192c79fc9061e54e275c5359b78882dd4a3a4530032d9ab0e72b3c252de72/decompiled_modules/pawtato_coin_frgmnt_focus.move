module 0x4d2192c79fc9061e54e275c5359b78882dd4a3a4530032d9ab0e72b3c252de72::pawtato_coin_frgmnt_focus {
    struct PAWTATO_COIN_FRGMNT_FOCUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_FOCUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_FOCUS>(arg0, 9, b"FRGMT_FOCUS", b"Pawtato Fragment of Focus", b"This fragment sharpens the mind like a blade. Distractions fade, and purpose burns bright as the midday sun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-focus.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_FOCUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_FOCUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

