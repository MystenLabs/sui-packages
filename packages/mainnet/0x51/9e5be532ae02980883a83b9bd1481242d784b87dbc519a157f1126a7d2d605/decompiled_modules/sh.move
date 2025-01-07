module 0x519e5be532ae02980883a83b9bd1481242d784b87dbc519a157f1126a7d2d605::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"HUNCHO ", b"Simply Greatness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea6c361b-93b4-4b72-91ca-70a9292a31d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

