module 0x2b1a2fb7974931a687dd29e934f95496f1e43c38bf5e99b36c5a4fc48a050cd0::qwekqwak {
    struct QWEKQWAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEKQWAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEKQWAK>(arg0, 6, b"Qwekqwak", b"Qwekaqua NO SODA", b"Qwekaqua #nosoda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F64_D9_AC_8_1_D1_B_43_BE_8500_EA_73_FF_0_A35_C1_e9cf3544a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEKQWAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWEKQWAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

