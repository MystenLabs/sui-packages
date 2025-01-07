module 0xff62523d971bfc77b4bb2ac10a84146ac6d066e9d1cf957a40aaf048cf15f170::dwr {
    struct DWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWR>(arg0, 9, b"DWR", b"DESERTWAR", b"coin of desert war", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53938c74-6e1f-46bd-ac4b-e2bc1c8e6b44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

