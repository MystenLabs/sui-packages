module 0xab67dcc9892ed62db045594d1f503bf0ca3707a270f68a750bc8ec9fcab9cee8::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"Dolphin", b"Dolphin ON Turbos", x"446f6c7068696e204f4e20547572626f73efbc8c446f6c7068696e204f4e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950011576.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

