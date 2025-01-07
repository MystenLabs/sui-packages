module 0xe4b3a10d31e0507857a746e4054118ef022345f596d909e86fd91da66412ba2::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"Pika", x"54696d6520746f20666c697020646f677320262066726f6773210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PJHT_Xiiw_Uej_Qjk_Lt_Vk_X_Ab_DW_Apy3j_Zv_Ye_Bwk5nf_P_Ub_Z43_e5e859b597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

