module 0xd76dde5abd584777f445ab421a2e143c4daf403859871681c947e76d4853791c::psm {
    struct PSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSM>(arg0, 9, b"PSM", b"PMSD", b"Prisanmah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43545ad3-20ef-479b-a621-ead433ae7e2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

