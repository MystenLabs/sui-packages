module 0x146cacda280140c0c9a3212b58c80ad97b34677c9b5ef6a55193d6941640b039::bod {
    struct BOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOD>(arg0, 6, b"BOD", b"BOOK OF DOGE", x"424f4f4b204f4620444f4745204d414b4520444f474520475245415420414741494e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Zi_Bnj_MW_Ua_H1ugvdm_V9i_R5n3oat_Gg_KR_2_Mg_Z_Cavyyzh_Ba_9980d9ad7b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

