module 0x854d3b969c57e0a0cd2e139cd5ee0e2b303849114c4d7442e596ee90be46fedb::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 6, b"NGMI", b"niggas gonna make it", b"NGMI bro...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U86_Z_Spy_Xaoc_Yx_JX_Hu_QU_6_Lyz7_Mq_Hi_G_Xb_YS_3nh_Wgd42d_Yi_b012883a26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

