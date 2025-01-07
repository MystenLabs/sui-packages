module 0x628fa9773173e986aad9dd15c7eb144a6d3eb22ddc84ec0f0f5f9f28881605ff::blg21 {
    struct BLG21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLG21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLG21>(arg0, 9, b"BLG21", b"BLERG", b"playful funny clumsy meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9c225f2-36f5-4b73-b1b9-b875b68a0300.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLG21>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLG21>>(v1);
    }

    // decompiled from Move bytecode v6
}

