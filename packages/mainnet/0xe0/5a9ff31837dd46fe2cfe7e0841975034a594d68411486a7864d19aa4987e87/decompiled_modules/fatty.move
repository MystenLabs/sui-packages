module 0xe05a9ff31837dd46fe2cfe7e0841975034a594d68411486a7864d19aa4987e87::fatty {
    struct FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATTY>(arg0, 6, b"Fatty", b"Milady Lorina", b"She loves to kill projects, ladies and gentlemen, meet Fatty on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CE_2106_B2_FD_1_E_4579_BD_6_E_EBF_9_C8_EB_14_AB_8c0ba349e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

