module 0xdbf292d0ba1da336c62cd14323dc03711e332bc6f5096de756d19d359c86aaa8::dcab {
    struct DCAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCAB>(arg0, 6, b"DCAB", b"DogeCab", b"Bonk bonk ur ride is here. Dont werry is a robotaxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nvs_Ra_Gjng_N28_SM_Yj3_Taye_Mi_KF_Wpgas_F_Eo_SKMNV_Wyqohg_cf658eb7b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

