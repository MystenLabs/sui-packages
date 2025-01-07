module 0x8ab14b24ff182477cb174a2443ef01d37673aa91ebbf160804cb62a43688c747::rober {
    struct ROBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBER>(arg0, 6, b"ROBER", b"ROBER THE ANGRY CAT", b"The angriest cat on sui chain. Dont touch me mfer! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_cartoon_illustration_of_a_white_cat_wearing_roun_a_Pc_Gwgao_RUO_3x_P3_W_Tjzu_KQ_8p_O8f_Qf_USY_Oz_Bfx2b_A_Fu_Tw_c0be25ecd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

