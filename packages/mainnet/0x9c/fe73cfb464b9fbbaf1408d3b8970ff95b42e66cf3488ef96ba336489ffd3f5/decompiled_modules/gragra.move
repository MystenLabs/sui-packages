module 0x9cfe73cfb464b9fbbaf1408d3b8970ff95b42e66cf3488ef96ba336489ffd3f5::gragra {
    struct GRAGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAGRA>(arg0, 9, b"GRAGRA", b"Gra gra", b"Gra fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c5c863d-ffdc-401d-aa03-034e808f263a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

