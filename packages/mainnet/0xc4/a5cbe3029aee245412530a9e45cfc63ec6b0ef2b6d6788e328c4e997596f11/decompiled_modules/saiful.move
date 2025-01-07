module 0xc4a5cbe3029aee245412530a9e45cfc63ec6b0ef2b6d6788e328c4e997596f11::saiful {
    struct SAIFUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIFUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIFUL>(arg0, 9, b"SAIFUL", b"wewe", b"cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7958e226-6961-4ffe-8211-d69d8550d69f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIFUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIFUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

