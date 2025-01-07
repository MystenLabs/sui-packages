module 0xfd57037da505e328c3c6ed6919a2d921f8c40be895a00935d1b723f1479bc88d::pumptrump {
    struct PUMPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTRUMP>(arg0, 6, b"PUMPTRUMP", b"Pumpit", b"Buy for Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Wqdjtxvd_Lgmek_L_Hq_G8boi_Vg5j_W_Br9_Vqh_A7_G_Fs_Fcmsa_V_21c2c1e2c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

