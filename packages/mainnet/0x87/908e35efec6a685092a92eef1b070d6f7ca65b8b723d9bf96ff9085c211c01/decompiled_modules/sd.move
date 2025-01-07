module 0x87908e35efec6a685092a92eef1b070d6f7ca65b8b723d9bf96ff9085c211c01::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 9, b"SD", b"GFJ", b"CVHJ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b70613a-8c8f-48b1-b3a2-98eaab747424.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

