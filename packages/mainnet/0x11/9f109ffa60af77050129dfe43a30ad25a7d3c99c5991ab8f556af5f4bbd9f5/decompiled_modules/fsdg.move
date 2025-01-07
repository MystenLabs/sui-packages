module 0x119f109ffa60af77050129dfe43a30ad25a7d3c99c5991ab8f556af5f4bbd9f5::fsdg {
    struct FSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDG>(arg0, 9, b"FSDG", b"FD", b"DGSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cade27ed-ff2d-4feb-93f3-bcf61816fcfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

