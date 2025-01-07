module 0x92d73c664918d10607a73ab70e0ec9d0ddb1eb2d0a422a7c6ac2c9c7f0bf6f7e::thenotorious {
    struct THENOTORIOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THENOTORIOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THENOTORIOUS>(arg0, 6, b"THENOTORIOUS", b"TheNotorious", b"Surprise surprise motherfuckers, the King is there. This ambitious token was created by The_Notorious_MMA fans, and is entirely in the diamondhands of the fan community. We will conquer all the peaks here, so this will last for a long-long time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Mo2_S_Nv_Vp_K2_Ee_C7_Ndzcbz8_Kn_Dp_W1_A5_Cj_CX_Yqm16_X_Uz6_M_01d026e4bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THENOTORIOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THENOTORIOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

