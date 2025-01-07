module 0x144a0a423366e8b719690b9a0eb0bca2498d1fb2c906465dcd460fcc840fe76c::cane {
    struct CANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANE>(arg0, 6, b"Cane", b"Cane Toad", x"536369656e7469666963206e616d65206f6620617175617269756d20746f61642068747470733a2f2f782e636f6d2f6d6979616a696d615f617175612f7374617475732f31383433313032333334333833323638333338202068747470733a2f2f6e617475726572756c6573312e66616e646f6d2e636f6d2f77696b692f43616e655f546f61640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Tgopp_DKY_Uw_Yu6_Rbfekotk6_En7s_Ac_Pdig_Sqd_Jxf_Zpz_Zq_645f7cd059.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

