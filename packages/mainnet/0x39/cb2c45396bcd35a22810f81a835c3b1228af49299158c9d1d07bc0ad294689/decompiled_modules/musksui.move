module 0x39cb2c45396bcd35a22810f81a835c3b1228af49299158c9d1d07bc0ad294689::musksui {
    struct MUSKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKSUI>(arg0, 9, b"MUSKSUI", b"musksui", b"Musksui new memecoin in sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad868bd8-a380-41ed-bfac-b91fd3f44bed-1000058442.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

