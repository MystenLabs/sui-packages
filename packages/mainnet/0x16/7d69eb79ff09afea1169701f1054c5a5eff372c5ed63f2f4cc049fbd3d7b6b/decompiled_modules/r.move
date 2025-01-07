module 0x167d69eb79ff09afea1169701f1054c5a5eff372c5ed63f2f4cc049fbd3d7b6b::r {
    struct R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R>(arg0, 9, b"R", b"Rio", b"Rio token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b631b153-3772-4be0-bc49-e2184b9f9464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R>>(v1);
    }

    // decompiled from Move bytecode v6
}

