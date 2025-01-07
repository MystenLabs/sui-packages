module 0x11daf0bfa9895dbc75f7f5b3facffaad96b9c802598e65bc59e9f656c883cb97::ups {
    struct UPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPS>(arg0, 9, b"UPS", b"Uptrends", b"This meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed528327-1420-43ec-a43b-3eff82ea333a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

