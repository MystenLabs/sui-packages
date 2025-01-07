module 0x780f42d0d740c0869c9876be512ddf2a4ad482076ebf9c1e1ff8abfaaa6359a1::cakedoge {
    struct CAKEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKEDOGE>(arg0, 6, b"CAKEDOGE", b"CAKEDOG", b"just cakedog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbks_Z_Tbn_Ux6_Je_Wy_BR_6t_Lf_Y56_Ju_Lde_Bz2xh_MWA_Jgqrkjb_Y_5fc14ed647.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKEDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAKEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

