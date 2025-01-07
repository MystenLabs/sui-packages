module 0xdc3f331a5fcd5c25f3bd922efce2b7839827c61962b6393f8eea6f7dac1ba11c::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 6, b"KIT", b"KIT CAT", x"5375692773206661766f726974652070657420244b495420697320636f6d696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma8dk_Tw_Cctrh_SQQ_Riguob_Bv6g_Tu_E_Vd_N_Eij_Rt_Etbab36qj_c9a8bb6660.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

