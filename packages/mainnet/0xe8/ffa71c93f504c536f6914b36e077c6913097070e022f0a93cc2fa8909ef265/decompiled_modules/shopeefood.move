module 0xe8ffa71c93f504c536f6914b36e077c6913097070e022f0a93cc2fa8909ef265::shopeefood {
    struct SHOPEEFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOPEEFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOPEEFOOD>(arg0, 9, b"SHOPEEFOOD", b"Wldn24", b"Send foods into customer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59b64dd2-4f74-4a18-a42d-71e1a658dd93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOPEEFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOPEEFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

