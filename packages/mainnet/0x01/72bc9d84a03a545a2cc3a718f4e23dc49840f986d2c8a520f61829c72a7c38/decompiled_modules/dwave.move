module 0x172bc9d84a03a545a2cc3a718f4e23dc49840f986d2c8a520f61829c72a7c38::dwave {
    struct DWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWAVE>(arg0, 6, b"DWAVE", b"DWAVE KWEIMAN", b"I AM DWAVE THE BTC OWNER ALL HEADLINES ARE ON ME ATM. I AM META", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Dg_Ra7_So_AC_Zi_R_Mnx5kmwxqq2f_QG_Joyd_UES_8_UBT_Nnw_Z_Jg_f131b8cb98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

