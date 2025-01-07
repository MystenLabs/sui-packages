module 0x727178710714df38e922a576320d8226eb3b141ecd8916c003c554a6baaa3c7d::dodo_27124 {
    struct DODO_27124 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO_27124, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO_27124>(arg0, 9, b"DODO_27124", b"DoDo", b"DoDo Friendly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7f29565-0ebf-4cc0-bf5e-d94930fe43ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO_27124>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DODO_27124>>(v1);
    }

    // decompiled from Move bytecode v6
}

