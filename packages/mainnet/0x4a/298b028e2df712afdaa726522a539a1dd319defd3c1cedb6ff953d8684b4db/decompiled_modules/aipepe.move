module 0x4a298b028e2df712afdaa726522a539a1dd319defd3c1cedb6ff953d8684b4db::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 9, b"AIPEPE", x"4149205045504520f09fa496", b"This token is the first memecoin created by a neural network for neural networks. No one knows where it came from. It is said to have been coded by the AI system itself in a secret project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb22816d-386c-460b-8f60-7adbe405d244.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

