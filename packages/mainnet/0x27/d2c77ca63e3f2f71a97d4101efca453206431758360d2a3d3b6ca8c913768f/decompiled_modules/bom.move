module 0x27d2c77ca63e3f2f71a97d4101efca453206431758360d2a3d3b6ca8c913768f::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 6, b"BOM", b"Bag Of Memes", b"A full bag of MEMES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_UXW_Db_Nfpof_Rc_Dt_Zkna_Fq_M1_UL_4_Kty_Q_Cm_Nk_Chs4c7_Up5_V_2d1d00ebed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

