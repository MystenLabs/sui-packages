module 0x8d20e52ccf54a096ad297d4b5f1f0aa24690a0a5c478b69dbc2a8b78f0434471::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 9, b"WEWE", b"Ojhri ", b"A man name wewewe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b05d5ea9-e6f2-42a7-92a2-3f007db76aee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

