module 0x70b3b6f1713d159052995136a3561e0281663a7164ef900501f483641aa88e06::desu {
    struct DESU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESU>(arg0, 6, b"DESU", b"DEDU SUI", b"Everyone knows a $DEDU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ci_Unt_Y1_Gae_Aib_Vofd_Hp5_Pu_Kcom_WZ_Zrn_H2khz_KH_Ueu_C8_R_01e80deac6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESU>>(v1);
    }

    // decompiled from Move bytecode v6
}

