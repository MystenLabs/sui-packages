module 0x854204e654496d66d6318fe97669cdc8c14f418c44730314756ca9487c58a608::hust {
    struct HUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUST>(arg0, 9, b"HUST", b"HUSTER", b"Meme on SUI of Hanoi University of Science and Technology (HUST).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/caca1089-c876-4021-ba5c-68df08054f3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

