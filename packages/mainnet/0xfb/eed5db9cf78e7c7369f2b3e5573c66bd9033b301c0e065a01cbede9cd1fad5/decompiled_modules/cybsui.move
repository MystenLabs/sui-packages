module 0xfbeed5db9cf78e7c7369f2b3e5573c66bd9033b301c0e065a01cbede9cd1fad5::cybsui {
    struct CYBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBSUI>(arg0, 6, b"CYBSUI", b"CyberSUI", b"Forged in the data nodes of the Sui Blockchain, CyberSUI was created as more than just a tokenits a vision. The vision? To bring together a vast network of crypto enthusiasts, dreamers, and innovators in one unified community, all riding the bullish wave of technological evolution. CyberSUI isnt just about profits; its about being part of the CyberHerd, a group of passionate supporters pushing the boundaries of whats possible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cyborg_Bull_9aa20dced0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

