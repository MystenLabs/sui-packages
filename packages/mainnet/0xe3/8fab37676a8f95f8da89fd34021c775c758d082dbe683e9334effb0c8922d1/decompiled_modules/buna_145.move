module 0xe38fab37676a8f95f8da89fd34021c775c758d082dbe683e9334effb0c8922d1::buna_145 {
    struct BUNA_145 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNA_145, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNA_145>(arg0, 9, b"BUNA_145", b"Buna ", b"For entertainment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ce1b771-5009-420a-ae2d-8a7b017a4c2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNA_145>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNA_145>>(v1);
    }

    // decompiled from Move bytecode v6
}

