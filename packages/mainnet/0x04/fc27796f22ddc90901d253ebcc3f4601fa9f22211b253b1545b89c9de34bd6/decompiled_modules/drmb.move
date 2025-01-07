module 0x4fc27796f22ddc90901d253ebcc3f4601fa9f22211b253b1545b89c9de34bd6::drmb {
    struct DRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRMB>(arg0, 9, b"DRMB", b"Drymba", b"Drymba, snooze, vargan is an overtone self-voiced reed plucked instrument.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52aab4ea-aa39-4042-87a1-5a01124b4ff5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

