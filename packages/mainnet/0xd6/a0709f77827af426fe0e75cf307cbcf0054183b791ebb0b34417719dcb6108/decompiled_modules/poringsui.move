module 0xd6a0709f77827af426fe0e75cf307cbcf0054183b791ebb0b34417719dcb6108::poringsui {
    struct PORINGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORINGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORINGSUI>(arg0, 9, b"PORINGSUI", b"Poring", b"Have fun with $PORING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/421f3515-984d-4837-8fdb-0a387971a12e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORINGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORINGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

