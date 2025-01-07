module 0x8e8ad61a07b37abc703201a9ad2f1d1dfaeca4d0cb689bfb6421ad9b5910e67f::sugong {
    struct SUGONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGONG>(arg0, 6, b"Sugong", b"Sui dugong", b"Im Sugong. Sugong deez nuts ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_D125_C6_A_4364_4_B3_F_9_DF_3_8_E0_B52_F953_A6_264bad4b49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

