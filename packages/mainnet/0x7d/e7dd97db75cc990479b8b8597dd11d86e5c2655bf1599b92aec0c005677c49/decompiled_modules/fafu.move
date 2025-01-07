module 0x7de7dd97db75cc990479b8b8597dd11d86e5c2655bf1599b92aec0c005677c49::fafu {
    struct FAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFU>(arg0, 9, b"FAFU", b"Fafafufu", b"www.fafu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f06881a8-0f08-41f1-836c-447d2d62befe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

