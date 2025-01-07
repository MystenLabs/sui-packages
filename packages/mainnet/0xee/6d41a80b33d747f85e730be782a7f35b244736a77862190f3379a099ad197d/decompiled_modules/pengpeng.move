module 0xee6d41a80b33d747f85e730be782a7f35b244736a77862190f3379a099ad197d::pengpeng {
    struct PENGPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGPENG>(arg0, 6, b"PENGPENG", b"Penguins", b"Community owned 100%. No Team wallets. Let's pump. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TWINS_TRH_Ej_Y_ld_Zddl_Xsz9ru_84571ff305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

