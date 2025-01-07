module 0x7b95dbf97619a6a7c2edac1126eb6fe9f5f3727f51cd81e8d5da036056a04db6::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"Big Butt Starfish", x"496d20424253202d207468652042696720427574742053746172666973680a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_mascot_logo_design_of_a_arrogant_looking_witchmascot_l_42eb19a4_3d97_492f_89ed_546b58fe41fe_2_e6744309a6_85fbf2031f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

