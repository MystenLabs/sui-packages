module 0x12e4af0f413173e0484c0ae38f1989044e7fa957b990a3aa314f5ea44ba9e7d5::masui {
    struct MASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASUI>(arg0, 6, b"MASUI", b"MA ON SUI", b"MASUI, a mischievous, cuddly embodiment of the Panic Monster, is a reminder that even when facing overwhelming tasks, a focused, efficient approach is key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Nlb_Ocak_A_Af712_674eec4760.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

