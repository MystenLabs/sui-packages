module 0x936a5a005cc33248d1bc0639e74f7bd8ab7a920669310caf16ae1c7ed200e837::coinn {
    struct COINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINN>(arg0, 9, b"COINN", b"88Coin", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3be56035-91bd-4a4a-9a2f-6308a9874970.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

