module 0x2c458bdfc0baa67284a9c57cbabc090734e269d16373c9ae7a374736c3e80235::pibit {
    struct PIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIBIT>(arg0, 9, b"PIBIT", b"pinkRabbit", b"FOLLOW THE PINK RABBIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a0f493e-015e-4f3f-8681-450f16d7a97d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

