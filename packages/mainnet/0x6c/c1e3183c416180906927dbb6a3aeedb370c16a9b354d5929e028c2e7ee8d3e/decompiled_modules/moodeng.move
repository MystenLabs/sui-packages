module 0x6cc1e3183c416180906927dbb6a3aeedb370c16a9b354d5929e028c2e7ee8d3e::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"moodengtoken", b"A place for collecting all of the best moo-deng pictures, memes, videos etc. be kindo Any posts about crypto will be an immediate permanent ban.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uyrv_NA_Ck_VV_Koi1_Ri9f_Msrib3_Jdy_BU_4oepu_Ludh_WU_Zqd7_501ebbdcbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

