module 0xdc0723b8871279eb12ed5ead5d6c189a93f286d450b3fd70046c17601aba1c84::drmb {
    struct DRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRMB>(arg0, 9, b"DRMB", b"Drymba", b"Drymba, snooze, vargan is an overtone self-voiced reed plucked instrument.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aec37d3b-da95-4382-87df-4a81ae1525f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

