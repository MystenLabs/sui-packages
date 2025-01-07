module 0x680aed433cce09c8a1f03c2365ec1ad880465ab354135299f0cfc4d76067c29e::shopeefood {
    struct SHOPEEFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOPEEFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOPEEFOOD>(arg0, 9, b"SHOPEEFOOD", b"Wldn24", b"Send foods into customer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0cca2c57-3709-43ed-ad6b-1efc9e08c70e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOPEEFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOPEEFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

