module 0xa76becce582d679aa1ba8faa2cda9fc60e6e235f0acc22a66577c56764453add::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"MooDeng Sui", x"57656c636f6d6520746f20746865204d6f6f2044656e6720736f20637574652070726f6a6563742c207765206861766520706c616e20746f2062652074686520637574657374204869706f706f74616d6f206f6620616c6c205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdk_Cmei_X_Jzo_T3_S9vha_Zigo_E_Zv5b_Wh_J3_Pv7_Vk5nw_Vd8_NK_3_1_0925fac83b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

