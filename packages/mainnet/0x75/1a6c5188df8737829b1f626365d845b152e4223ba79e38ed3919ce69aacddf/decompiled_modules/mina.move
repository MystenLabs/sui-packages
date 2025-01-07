module 0x751a6c5188df8737829b1f626365d845b152e4223ba79e38ed3919ce69aacddf::mina {
    struct MINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINA>(arg0, 9, b"MINA", b"MINATHOI", b"Cool token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3535a3db-6ce2-4ba9-898d-99ad2ba7c9e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

