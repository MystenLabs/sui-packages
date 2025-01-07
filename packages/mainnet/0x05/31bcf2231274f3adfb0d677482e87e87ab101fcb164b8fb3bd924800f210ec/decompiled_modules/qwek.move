module 0x531bcf2231274f3adfb0d677482e87e87ab101fcb164b8fb3bd924800f210ec::qwek {
    struct QWEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEK>(arg0, 6, b"Qwek", b"Qwekaqua", b"QwekQwak ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F64_D9_AC_8_1_D1_B_43_BE_8500_EA_73_FF_0_A35_C1_4d6eb4330b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

