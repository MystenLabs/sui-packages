module 0x3753d9a2be9097d5f7591f85a43f296ca3364e227e3f7897b51601c1cc07ee2c::kkg {
    struct KKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKG>(arg0, 9, b"KKG", b"Kingsfx", b"Football token gamepad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f8ecd9a-f92c-41e3-89e0-dafa50263392.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

