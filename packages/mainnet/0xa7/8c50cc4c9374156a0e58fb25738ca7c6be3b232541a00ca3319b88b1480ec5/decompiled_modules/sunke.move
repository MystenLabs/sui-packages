module 0xa78c50cc4c9374156a0e58fb25738ca7c6be3b232541a00ca3319b88b1480ec5::sunke {
    struct SUNKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNKE>(arg0, 6, b"SUNKE", b"SUNKE CTO", b"FUCK DEV CTO NOW ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_69_3f650ddf55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

