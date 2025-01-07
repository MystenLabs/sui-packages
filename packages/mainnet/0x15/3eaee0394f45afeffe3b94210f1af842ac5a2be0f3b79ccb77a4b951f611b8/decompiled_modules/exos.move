module 0x153eaee0394f45afeffe3b94210f1af842ac5a2be0f3b79ccb77a4b951f611b8::exos {
    struct EXOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXOS>(arg0, 9, b"EXOS", b"EXINOS", b"Fun token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cb5dce2-8905-4651-9e52-03adfe7603d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

