module 0x13916d354888cc6e0347afb98f8bd02dda98e5fe1d153e02c30e03d8651a5926::hween {
    struct HWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWEEN>(arg0, 9, b"HWEEN", b"Halloween", b"The horror of flying on the wings of the night.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86b346cb-1de5-4595-9e44-61192650898b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

