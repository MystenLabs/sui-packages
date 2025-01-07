module 0x4997b6c40ba9e4b90fccd7e49e1f03c3a7cf307e61604fdab692997eeb8f029e::cwhl_123 {
    struct CWHL_123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWHL_123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWHL_123>(arg0, 9, b"CWHL_123", b"CWHALE", b"CWHALE TOKEN IS MARKETING ENTUASIASTIVE VISION TOKEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19bdeaf0-a1ee-4097-8441-a0d3570da453.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWHL_123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWHL_123>>(v1);
    }

    // decompiled from Move bytecode v6
}

