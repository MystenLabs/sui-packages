module 0xdc59ac767a859bb6a693630f7f3232a67bec6d7ea683e954166ac84785f934fc::soccer_ai {
    struct SOCCER_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCCER_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCCER_AI>(arg0, 9, b"SOCCER_AI", b"SOCCER  AI", b"Beyond the pitch, AI streamlines club operations. From dynamic ticket pricing to merchandise sales, AI enables clubs to make data-driven decisions, optimizing revenue streams and enhancing the overall business model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3cf8a58-1a3a-4ae5-b99d-7bbdc69faa17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCCER_AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCCER_AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

