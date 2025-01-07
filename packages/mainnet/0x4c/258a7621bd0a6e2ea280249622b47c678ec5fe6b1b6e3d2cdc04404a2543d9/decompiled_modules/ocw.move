module 0x4c258a7621bd0a6e2ea280249622b47c678ec5fe6b1b6e3d2cdc04404a2543d9::ocw {
    struct OCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCW>(arg0, 9, b"OCW", b"Ocean wif", b"The Ocean wears a hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/778770c9-dd2b-4c0c-be77-ea888e517cff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCW>>(v1);
    }

    // decompiled from Move bytecode v6
}

