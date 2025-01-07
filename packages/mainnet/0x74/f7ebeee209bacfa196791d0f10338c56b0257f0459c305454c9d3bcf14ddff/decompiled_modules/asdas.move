module 0x74f7ebeee209bacfa196791d0f10338c56b0257f0459c305454c9d3bcf14ddff::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 9, b"ASDAS", b"fgfg", b"DGFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/777cffa1-4480-4018-aba3-f45cf098e320.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

