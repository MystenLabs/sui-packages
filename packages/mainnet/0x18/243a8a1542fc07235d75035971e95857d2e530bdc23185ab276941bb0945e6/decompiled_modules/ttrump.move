module 0x18243a8a1542fc07235d75035971e95857d2e530bdc23185ab276941bb0945e6::ttrump {
    struct TTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTRUMP>(arg0, 6, b"TTRUMP", b"TURBO TRUMP", b"TURBO TRUMP TURBOING TO A BILLION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma8_Esz_Zd_TPCK_6_XS_3_KF_2g_B8km_T_Fny_J_Fww_Vgd2q3o_HW_3_Tpd_83bf670622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

