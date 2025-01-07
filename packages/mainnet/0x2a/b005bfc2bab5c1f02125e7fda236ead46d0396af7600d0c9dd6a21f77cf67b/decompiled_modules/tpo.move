module 0x2ab005bfc2bab5c1f02125e7fda236ead46d0396af7600d0c9dd6a21f77cf67b::tpo {
    struct TPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPO>(arg0, 9, b"TPO", b"TRUMPO", b"Its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/557a96ab-5b0a-4ce3-a33a-1088bd25c3da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

