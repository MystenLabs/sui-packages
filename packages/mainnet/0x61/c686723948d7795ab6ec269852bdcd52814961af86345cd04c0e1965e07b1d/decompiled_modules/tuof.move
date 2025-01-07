module 0x61c686723948d7795ab6ec269852bdcd52814961af86345cd04c0e1965e07b1d::tuof {
    struct TUOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUOF>(arg0, 9, b"TUOF", b"FFW;", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3a41707-dadc-4863-ac59-51e2fa4a50b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

