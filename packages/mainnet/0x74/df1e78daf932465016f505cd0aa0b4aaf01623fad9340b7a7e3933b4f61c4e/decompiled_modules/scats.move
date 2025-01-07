module 0x74df1e78daf932465016f505cd0aa0b4aaf01623fad9340b7a7e3933b4f61c4e::scats {
    struct SCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATS>(arg0, 9, b"SCATS", b"SuiCats", b"The world of Sui Cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed9970d4-b117-47ef-89f7-3dea069586dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

