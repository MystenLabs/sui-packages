module 0x5b564450e8d1f678bb98bb77dafb23945a0e7f8ad89ffecdde68f367c48e8811::badai {
    struct BADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADAI>(arg0, 6, b"BADAI", b"CAT BAD AI", b"CATBAD AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_AF_42_J1bh_BT_Hsbuwj_j_W5tg_A_t500x500_489a4269dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

