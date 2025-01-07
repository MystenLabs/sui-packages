module 0xb80f7bf4344fbd643346a3e4caef1e3feb51981909aef947040579a45d302560::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"MAD", b"Mad Meme", x"244d4144202d205468652057696c6420446567656e2077686f20687573746c6573206861726420616e6420706172746965732068617264657220204a6f696e2074686520234d656d657341667465724461726b20446567656e204d6f76656d656e74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q8_Rw_Nb7_JG_Lx_Wg_Mt_WU_3_Vo_C7_Gqie_WA_Hs_L_Cs9qe5z_LZ_6y_BW_cd222bf9bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

