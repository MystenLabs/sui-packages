module 0xcd2f8b9b6ebf921c7dc69fdb05ffa935be5fa1d13dfce4c6b90477df031b8ddd::vmh {
    struct VMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMH>(arg0, 9, b"VMH", b"vmhoangit", b"vmhoangit1408", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3faf405a-b63e-49dd-bafb-058e20a5907e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

