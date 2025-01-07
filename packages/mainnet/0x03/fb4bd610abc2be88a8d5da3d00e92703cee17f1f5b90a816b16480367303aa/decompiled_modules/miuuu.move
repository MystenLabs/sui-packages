module 0x3fb4bd610abc2be88a8d5da3d00e92703cee17f1f5b90a816b16480367303aa::miuuu {
    struct MIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIUUU>(arg0, 9, b"MIUUU", b"miumiu", b"MIUUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6d4e1b0-bb45-4c49-877a-34d86ba05cfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

