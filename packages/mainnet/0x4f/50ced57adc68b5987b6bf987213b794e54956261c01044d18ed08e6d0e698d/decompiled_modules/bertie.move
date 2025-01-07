module 0x4f50ced57adc68b5987b6bf987213b794e54956261c01044d18ed08e6d0e698d::bertie {
    struct BERTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERTIE>(arg0, 6, b"Bertie", b"SuiBertie", b"Fastest turtle in the world - Official Guinness record holder with a MINDBLOWING speed of 0.28 m/s (0.92 ft/s)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qqis_X_Yzfr_ZB_Se_C49_Sok_Ga2c2_Wj_X_Ht_Zc_Ab_Ao1_U3p_BD_Jty_9610b78d5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

