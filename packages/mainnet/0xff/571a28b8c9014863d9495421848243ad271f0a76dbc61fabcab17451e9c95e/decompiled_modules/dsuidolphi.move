module 0xff571a28b8c9014863d9495421848243ad271f0a76dbc61fabcab17451e9c95e::dsuidolphi {
    struct DSUIDOLPHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUIDOLPHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSUIDOLPHI>(arg0, 9, b"DSUIDOLPHI", b"sDolphin", b"dolphin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/918dbb3b-779e-46ac-bdde-fc900a277217.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUIDOLPHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSUIDOLPHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

