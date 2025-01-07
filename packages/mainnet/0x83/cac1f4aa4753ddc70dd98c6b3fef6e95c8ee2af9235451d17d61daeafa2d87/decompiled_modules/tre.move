module 0x83cac1f4aa4753ddc70dd98c6b3fef6e95c8ee2af9235451d17d61daeafa2d87::tre {
    struct TRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRE>(arg0, 9, b"TRE", b"tree", b"Big wish tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a864e8bc-dbc1-4da7-ac72-8423fcfe6ee2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

