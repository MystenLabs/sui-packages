module 0x706a70209277b8c6e0b682f56b1eaa76a2aaebf7e7b9f21093fe37194c81d437::trsl {
    struct TRSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSL>(arg0, 9, b"TRSL", b"Trishul ", x"f09f94b1205472697368756c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/801f9df9-a96d-4dfe-a855-d6c2a9c49e3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

