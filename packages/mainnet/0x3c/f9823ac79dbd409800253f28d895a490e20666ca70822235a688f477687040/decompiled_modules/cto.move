module 0x3cf9823ac79dbd409800253f28d895a490e20666ca70822235a688f477687040::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 9, b"CTO", b"Cheems CTO", b"The Best Meme Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f259df50-d25d-4a47-b801-799ff9a6c41d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

