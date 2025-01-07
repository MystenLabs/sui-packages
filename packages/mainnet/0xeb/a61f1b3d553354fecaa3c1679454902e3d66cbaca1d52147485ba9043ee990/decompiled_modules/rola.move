module 0xeba61f1b3d553354fecaa3c1679454902e3d66cbaca1d52147485ba9043ee990::rola {
    struct ROLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLA>(arg0, 6, b"ROLA", b"Rola Coin", x"4661612044494e484549524f20636f6d206120524f4c412c2073656d206d6f7374726172206120524f4c4121202d224e6f20706f73736f2076657220756d612042435420717565206e616f207061726f2064652073756269722e2e2e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V2_Pb_Ue_H_Yk_G_Dk_Kh_G5dc5_D4_Pdw_LUT_Ra_BFSVN_Yd9bx_LBW_Hp_8c931a52d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

