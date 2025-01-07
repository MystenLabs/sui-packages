module 0x6fb83fde7234e0ea98b530812226c10c995a3056d9f3cfba8242c3e79b231f54::parvesui {
    struct PARVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARVESUI>(arg0, 6, b"PARVESUI", b"PARVE", x"546865206f6e6c7920746f6b656e206d6164652062792061207065727665727420616e64206d61646520666f722070657276657274730a427579204e6f770a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Yc_Hvy7t_Mhj_IQW_Tylw_Kxk0j_RTM_3b22a8fc75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

