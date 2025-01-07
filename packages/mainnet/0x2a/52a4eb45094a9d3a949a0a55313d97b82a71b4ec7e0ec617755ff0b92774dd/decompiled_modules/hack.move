module 0x2a52a4eb45094a9d3a949a0a55313d97b82a71b4ec7e0ec617755ff0b92774dd::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACK>(arg0, 9, b"HACK", b"Hacker", b"Nothing to change", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb075fbc-c1c9-4edf-ad2b-0e03d0bc5f55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

