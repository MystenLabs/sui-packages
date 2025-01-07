module 0xe9c234d8246a82d1299b97b47ef3ddf516af617792daf76d1ed40a2aa8a5a1c7::walidah {
    struct WALIDAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALIDAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALIDAH>(arg0, 9, b"WALIDAH", b"Walid", b"Sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa993450-7ae2-4741-a2da-fc610ae7534e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALIDAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALIDAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

