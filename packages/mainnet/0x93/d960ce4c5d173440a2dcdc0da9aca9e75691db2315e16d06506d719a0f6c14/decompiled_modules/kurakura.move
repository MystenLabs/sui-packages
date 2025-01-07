module 0x93d960ce4c5d173440a2dcdc0da9aca9e75691db2315e16d06506d719a0f6c14::kurakura {
    struct KURAKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURAKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURAKURA>(arg0, 9, b"KURAKURA", b"Kuracake", b"I like yellow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71637abd-4b17-4ac2-8753-3fedfacda91c-IMG_20240725_091248.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURAKURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KURAKURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

