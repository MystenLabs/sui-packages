module 0x5c0b5584cf5feb333a10666806175fb98ad0a970392862cd9db1473bc40dd0d6::pow {
    struct POW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POW>(arg0, 6, b"POW", b"pow", b"Just a cat with a gun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R9otos_LE_Xztv26_ST_Wp_Yqqc8_Ws4_L_Zj6_KF_Yca5_EW_6_SRH_Hm_f61305e8d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POW>>(v1);
    }

    // decompiled from Move bytecode v6
}

