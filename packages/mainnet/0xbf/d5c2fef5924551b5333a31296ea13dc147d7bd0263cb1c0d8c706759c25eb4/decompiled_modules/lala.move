module 0xbfd5c2fef5924551b5333a31296ea13dc147d7bd0263cb1c0d8c706759c25eb4::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALA>(arg0, 9, b"LALA", b"Labubu", b"Inspired by labubu, always bring you joy and luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/270c8ee6-4be4-427a-8306-27356187a34d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

