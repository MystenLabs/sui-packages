module 0x4e2bfb27141b71298fd0ea55684f6b1cbfc2128b002f4bbaee70117851c64dad::gdt {
    struct GDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDT>(arg0, 9, b"GDT", b"Godstime", b"It's a good project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9a63268-aa7d-44e5-b452-9f230212f19f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

