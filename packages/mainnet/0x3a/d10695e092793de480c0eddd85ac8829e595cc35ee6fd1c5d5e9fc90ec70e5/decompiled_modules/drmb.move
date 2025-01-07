module 0x3ad10695e092793de480c0eddd85ac8829e595cc35ee6fd1c5d5e9fc90ec70e5::drmb {
    struct DRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRMB>(arg0, 9, b"DRMB", b"Drymba", b"Drymba, snooze, vargan is an overtone self-voiced reed plucked instrument.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6cabe73-73a7-4236-9a72-d8652a3bb872.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

