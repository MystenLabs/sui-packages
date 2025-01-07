module 0x465bbcb3fe6c8af05e8fcb420ac9c5824cec686fbc7d06b0a326d8a1a7a1553::pown {
    struct POWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWN>(arg0, 9, b"POWN", b"Nowxen", b"Delete", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b368ce2-aaaf-41fb-8206-55a7aaef85f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

