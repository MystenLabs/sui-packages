module 0xc1fc3ad0b00d398f1ae257e13951d5441e6538ccdf1c52cad7194d7e62d07029::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 9, b"GHOST", b"Ghost ", b" Simon used to be an apprentice butcher at a grocery but joined the military after the September 11 attacks occurred. He eventually was accepted into the Special Air Service", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/faff699c-28a4-4398-ba30-f3b881778089.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

