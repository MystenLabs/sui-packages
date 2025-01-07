module 0x9e7f2e20bbfec532cfabaa1da72ff0e743e863d4cbf3e373cc1560588c706f49::azuki {
    struct AZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUKI>(arg0, 9, b"AZUKI", b"Azuki", b"Azuki meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad07cfd7-8d73-4c25-863e-685bedc0778f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

