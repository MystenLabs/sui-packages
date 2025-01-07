module 0xc04a64203124df536b92133dfd0926c013af4643fdde1d2fcc3d07c4ce36aa79::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 6, b"PeterTodd", b"Peter Todd", b"Peter Todd denies claims made in an HBO documentary that he is the creator of Bitcoin, Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Za_U_Wh_EW_4_AAH_Gwh_aff90c030e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

