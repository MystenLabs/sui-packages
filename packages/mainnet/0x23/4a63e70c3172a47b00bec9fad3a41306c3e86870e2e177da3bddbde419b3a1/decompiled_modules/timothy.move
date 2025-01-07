module 0x234a63e70c3172a47b00bec9fad3a41306c3e86870e2e177da3bddbde419b3a1::timothy {
    struct TIMOTHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMOTHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMOTHY>(arg0, 9, b"TIMOTHY", b"T Ronald", b"Timothy Ronald", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67be6b3f-0905-46c4-a267-fd7311b5e0bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMOTHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMOTHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

