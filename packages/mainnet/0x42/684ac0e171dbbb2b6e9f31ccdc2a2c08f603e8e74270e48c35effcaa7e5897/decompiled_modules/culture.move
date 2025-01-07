module 0x42684ac0e171dbbb2b6e9f31ccdc2a2c08f603e8e74270e48c35effcaa7e5897::culture {
    struct CULTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTURE>(arg0, 6, b"Culture", b"Invest on Culture", b"$Culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wy_Dyazs57n_Bg9_V66kiz_N_Ede_C3x7_CNABMR_6ma_S4_DLBZ_6_W_f1e3f219a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULTURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

