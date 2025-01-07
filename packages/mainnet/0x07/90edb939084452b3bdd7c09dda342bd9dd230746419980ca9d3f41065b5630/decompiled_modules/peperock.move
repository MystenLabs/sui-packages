module 0x790edb939084452b3bdd7c09dda342bd9dd230746419980ca9d3f41065b5630::peperock {
    struct PEPEROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEROCK>(arg0, 6, b"PepeRock", b"PePeRocks", b"Pepe sing a song", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RR_Hgt_M_Wd_H5yc_G_Ce_MH_Lq_M_Tqg_Fi_HXV_Py_Jyycqnw_L8k2oy_U_d7eb3901db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

