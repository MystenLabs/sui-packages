module 0x2ef5c3485b72273a8b3d8659d435f7f651845003c0282df4b13543357b2c845c::drmb {
    struct DRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRMB>(arg0, 9, b"DRMB", b"Drymba", b"Drymba, snooze, vargan is an overtone self-voiced reed plucked instrument.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27b0de93-b680-4c55-8825-b2ccf70046f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

