module 0xceaf262ea6714c3fbc7737f79b0ff729b4d560fc72b9f32c231d602338dfc28b::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 6, b"Mira", b"mira sui", b"Mira is a sui sloth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F6649_CF_2_88_E9_4_B04_9_D2_B_9118_FE_4944_D7_d754c46fd7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

