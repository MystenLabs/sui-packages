module 0xf1d73f37598810e0a8915d6fba802735046d2fe2c278f1b9140ebfcc1bf15922::election {
    struct ELECTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELECTION>(arg0, 6, b"ELECTION", b"Pump Election", x"50756d7020456c656374696f6e2c2077686f2077696c6c20796f7520766f746520666f723f20200a425559203d205472756d7020200a53454c4c203d2048617272697320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Wqdjtxvd_Lgmek_L_Hq_G8boi_Vg5j_W_Br9_Vqh_A7_G_Fs_Fcmsa_V_4fe68ef7af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELECTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

