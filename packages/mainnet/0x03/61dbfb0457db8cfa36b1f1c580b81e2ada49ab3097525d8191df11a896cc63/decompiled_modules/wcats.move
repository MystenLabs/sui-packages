module 0x361dbfb0457db8cfa36b1f1c580b81e2ada49ab3097525d8191df11a896cc63::wcats {
    struct WCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCATS>(arg0, 9, b"WCATS", b"Wiizz Cats", b"Be whatever you can be...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/686f6bb4-592f-4621-83ca-77b021dc8eb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

