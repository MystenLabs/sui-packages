module 0xf3a5de2cfaa32fd56f8c5e4d1cd7092476f20d5090870da6d4b838fd17963db::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 6, b"BBT", b"BABY TROLL", b"The Baby Troll Memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Harfxn1o4gmg_N_Asg_Es7cn_B_Qoqc_H_Qrw_Efc_FTS_84_ZRF_Mh_52e03e5ba1.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

