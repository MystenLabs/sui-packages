module 0x34369f9fa5d9c5f420d3e7418ba18481215be698f1a7ee7dd7d00a914416b0df::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 9, b"HODL", b"HODLER", b"Hodl coin every year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a42029e-7246-4f67-9a71-b683a1758f73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

