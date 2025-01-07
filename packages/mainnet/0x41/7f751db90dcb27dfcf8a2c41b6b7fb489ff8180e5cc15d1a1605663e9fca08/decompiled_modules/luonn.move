module 0x417f751db90dcb27dfcf8a2c41b6b7fb489ff8180e5cc15d1a1605663e9fca08::luonn {
    struct LUONN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUONN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUONN>(arg0, 9, b"LUONN", b"leluon", b"LALA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6cdad26-1dd1-4c35-baf5-29bab5e5fbd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUONN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUONN>>(v1);
    }

    // decompiled from Move bytecode v6
}

