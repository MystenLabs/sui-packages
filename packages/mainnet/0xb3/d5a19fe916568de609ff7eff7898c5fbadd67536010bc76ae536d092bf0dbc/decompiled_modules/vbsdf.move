module 0xb3d5a19fe916568de609ff7eff7898c5fbadd67536010bc76ae536d092bf0dbc::vbsdf {
    struct VBSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBSDF>(arg0, 9, b"VBSDF", b"VDSG", b"AFC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d0dc496-e384-4863-b967-d545b98d1509.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBSDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBSDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

