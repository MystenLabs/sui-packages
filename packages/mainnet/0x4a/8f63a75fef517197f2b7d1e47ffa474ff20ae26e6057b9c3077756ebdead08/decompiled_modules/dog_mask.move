module 0x4a8f63a75fef517197f2b7d1e47ffa474ff20ae26e6057b9c3077756ebdead08::dog_mask {
    struct DOG_MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MASK>(arg0, 9, b"DOG_MASK", b"Dogwifmask", b"Just a dog with mask ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e9ed1e-56f2-46ef-8b99-1df30c382ce9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

