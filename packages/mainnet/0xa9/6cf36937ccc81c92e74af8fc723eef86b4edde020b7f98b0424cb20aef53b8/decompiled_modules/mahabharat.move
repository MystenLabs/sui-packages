module 0xa96cf36937ccc81c92e74af8fc723eef86b4edde020b7f98b0424cb20aef53b8::mahabharat {
    struct MAHABHARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHABHARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHABHARAT>(arg0, 9, b"MAHABHARAT", b"Bheema ", b"Bheema is a meme coin inspired by Mahabharata it's enough to make you a future millionaire ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c5980af-e08a-4140-a58c-0352a157f88d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHABHARAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAHABHARAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

