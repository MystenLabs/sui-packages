module 0x3483cc7334577280dff8e770ad5d71597a3f0eddeea5730cf2ab3d751341a7cd::iend {
    struct IEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEND>(arg0, 9, b"IEND", b"bxc", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0fd28215-1f80-4f8d-b8cb-da36ac600e20.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

