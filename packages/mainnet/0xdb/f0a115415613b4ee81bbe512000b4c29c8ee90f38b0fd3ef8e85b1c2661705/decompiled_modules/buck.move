module 0xdbf0a115415613b4ee81bbe512000b4c29c8ee90f38b0fd3ef8e85b1c2661705::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 6, b"BUCK", b"Buck The Pup", b"Buck is the cutest pup on sui, on a mission to send $Buck to a Buck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc46_Zz9_WDL_Rpzfk73ft_X_Xjp_Vkv_Rr8vx_NN_Qrh_Qi_Es_P7r3_W_0a998da396.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

