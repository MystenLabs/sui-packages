module 0x7afb140c941d70b9cd954feaa0b0460063c4374edec5b2b8c5aa8e37f6182e50::x_boom {
    struct X_BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: X_BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X_BOOM>(arg0, 9, b"X_BOOM", b"X Boom", b"Way To Change ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59e7dfb8-f9b5-484f-b236-ae05198ab510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X_BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X_BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

