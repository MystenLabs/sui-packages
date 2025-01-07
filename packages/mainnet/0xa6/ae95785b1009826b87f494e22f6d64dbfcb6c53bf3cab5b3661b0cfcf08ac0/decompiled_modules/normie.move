module 0xa6ae95785b1009826b87f494e22f6d64dbfcb6c53bf3cab5b3661b0cfcf08ac0::normie {
    struct NORMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORMIE>(arg0, 6, b"NORMIE", b"Normie ON SUI", b"Im just a normie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_ZTVG_Ea_WY_7_Tippw4_Kzk_R7_LC_Uo_Dkd_UUV_Hxkattvu_XXH_4s_8b4afda94a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

