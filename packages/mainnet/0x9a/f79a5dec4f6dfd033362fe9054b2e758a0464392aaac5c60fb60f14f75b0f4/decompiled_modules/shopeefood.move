module 0x9af79a5dec4f6dfd033362fe9054b2e758a0464392aaac5c60fb60f14f75b0f4::shopeefood {
    struct SHOPEEFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOPEEFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOPEEFOOD>(arg0, 9, b"SHOPEEFOOD", b"Wldn24", b"Send foods into customer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bad9c6b2-9ce4-4a3a-9292-a848a57871c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOPEEFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOPEEFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

