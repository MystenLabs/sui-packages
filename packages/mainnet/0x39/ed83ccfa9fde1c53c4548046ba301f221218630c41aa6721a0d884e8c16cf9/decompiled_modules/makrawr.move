module 0x39ed83ccfa9fde1c53c4548046ba301f221218630c41aa6721a0d884e8c16cf9::makrawr {
    struct MAKRAWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKRAWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKRAWR>(arg0, 9, b"MAKRAWR", b"Tyz", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/338a8faa-4c4f-4204-9563-dbc81d9a900b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKRAWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAKRAWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

