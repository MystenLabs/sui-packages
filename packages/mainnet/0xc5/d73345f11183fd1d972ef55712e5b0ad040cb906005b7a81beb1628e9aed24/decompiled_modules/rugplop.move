module 0xc5d73345f11183fd1d972ef55712e5b0ad040cb906005b7a81beb1628e9aed24::rugplop {
    struct RUGPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPLOP>(arg0, 6, b"RUGPLOP", b"I WILL RUG PLOP", b"kerifmeumt8u4ty8n4iub6yi546i5,4u6b75i4u6m759876u589mb7u58bn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Pq29_VKR_56ym_V_Tx5q_VVUQ_9_H7zcy8jtr_L6rcr1_V_Gg_Tzg_H_a3258e6b3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

