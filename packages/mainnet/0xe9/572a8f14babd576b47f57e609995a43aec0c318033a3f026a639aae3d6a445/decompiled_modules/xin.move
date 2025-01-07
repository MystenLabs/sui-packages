module 0xe9572a8f14babd576b47f57e609995a43aec0c318033a3f026a639aae3d6a445::xin {
    struct XIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIN>(arg0, 9, b"XIN", b"xinthenho", b"BUBUBU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c32f2d4-1f47-442c-979e-e26b09207f48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

