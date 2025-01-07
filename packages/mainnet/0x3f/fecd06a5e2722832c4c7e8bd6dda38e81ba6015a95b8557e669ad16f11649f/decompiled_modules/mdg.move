module 0x3ffecd06a5e2722832c4c7e8bd6dda38e81ba6015a95b8557e669ad16f11649f::mdg {
    struct MDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDG>(arg0, 6, b"MDG", b"SUI MODEGA", b"MODEGA The new meme x100 in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8sm2cb_YM_La_JW_8st_TP_Bts_D_Zsq2_Je8_RH_6ddcw_GZ_Np_PQ_Koi_9fbd2a7ec4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

