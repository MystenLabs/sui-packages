module 0x7e67d99bd6e53bdb935da11d304425bf34c42c2ad4e52d99bf6d7aa55556e3c4::poppe {
    struct POPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPE>(arg0, 9, b"POPPE", b"Poppe Toad", b"The all-too-familiar toad that gives its holders privileges. What are they? Haha, let's find out together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b06423cf-7c8f-4d91-af6c-142b907d9cf3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

