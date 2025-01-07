module 0x47e701a5c478e2b6f3b53002b76c0d765bf4c56597e302ef9e347303079c7b52::pum {
    struct PUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUM>(arg0, 9, b"PUM", b"Pump", b"Pump Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bef772a-fc51-400e-b85f-b7cd0912266f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

