module 0x920ac78cd6c722553d2d69879314050400ea6fd64d0f998ead01c9c2259720c7::nafish {
    struct NAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAFISH>(arg0, 6, b"NAFish", b"NIKE AIR FISH", b"NIKE AIR and FISH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Bds_V_Gf5_Uw_Lcr_VXB_Tj4_Vqh_Db_Fp74xp1v6z_Ff_Ui4wa6b_G_47f4a29f2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

