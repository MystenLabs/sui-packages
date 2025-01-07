module 0xe99e71c7923da74c7378a43b88191823214803d988c43976f497e3f9cd246e0e::vcb {
    struct VCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCB>(arg0, 9, b"VCB", b"Vietmes", b"Kemem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1c3a0df-39c9-4bdd-a986-7458928ed338.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

