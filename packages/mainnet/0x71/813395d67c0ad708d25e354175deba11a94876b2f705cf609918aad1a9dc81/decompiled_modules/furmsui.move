module 0x71813395d67c0ad708d25e354175deba11a94876b2f705cf609918aad1a9dc81::furmsui {
    struct FURMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURMSUI>(arg0, 6, b"FURMSUI", b"FURMULA GAME", b"FURMULA is the highest class of international racing on SUI. Their presale has been done less than a minute with 10k SUI hardcap. Has lower cap compare to other gamefi projects. $FURM just launched recently. Has moved well, 44M area. Exchange listings soon. Good branding and ticker. Higher mcap play. Be safe if going in. Links Below. Dyor. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_001458_157_88e8f12fff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

