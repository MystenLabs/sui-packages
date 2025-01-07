module 0x6ce84d7dbf6a345e62788bae7621ead81211d0288ccca19ac98b5f671018403f::bondai {
    struct BONDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONDAI>(arg0, 6, b"Bondai", b"007BOND", b"Ai Agent Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/james_bond_007_nightfire_james_bond_007_blood_stone_james_bond_007_everything_or_nothing_png_favpng_p_Nq_Z3_C_Ej1wc_Vu_M_Qd_YFBA_Ah1_Jw_f2b14be32c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

