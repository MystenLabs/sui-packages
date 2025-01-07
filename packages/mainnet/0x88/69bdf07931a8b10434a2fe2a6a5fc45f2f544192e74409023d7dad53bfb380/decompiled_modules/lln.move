module 0x8869bdf07931a8b10434a2fe2a6a5fc45f2f544192e74409023d7dad53bfb380::lln {
    struct LLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLN>(arg0, 9, b"LLN", b"LlamaLoon", b" High-altitude llamas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c4ce952-096d-41eb-9e21-32acb365c50b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

