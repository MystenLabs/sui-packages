module 0x3279ea8a1afc51b14cb64936fdc5649c4811aab0e00b58b19ddbd2cad54e81a4::geko {
    struct GEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEKO>(arg0, 9, b"GEKO", b"GOKO", b"Geko soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc98d4bc-624e-4990-a7e3-20cdb97deaa8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

