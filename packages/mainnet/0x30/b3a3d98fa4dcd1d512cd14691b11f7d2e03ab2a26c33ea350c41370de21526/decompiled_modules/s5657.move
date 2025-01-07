module 0x30b3a3d98fa4dcd1d512cd14691b11f7d2e03ab2a26c33ea350c41370de21526::s5657 {
    struct S5657 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S5657, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S5657>(arg0, 9, b"S5657", b"hh", b"567567", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2cbbd7f-9465-4c30-94a0-28f2d9ae00e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S5657>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S5657>>(v1);
    }

    // decompiled from Move bytecode v6
}

