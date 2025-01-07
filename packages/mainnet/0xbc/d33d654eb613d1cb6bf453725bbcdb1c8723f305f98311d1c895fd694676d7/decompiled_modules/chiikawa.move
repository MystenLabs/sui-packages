module 0xbcd33d654eb613d1cb6bf453725bbcdb1c8723f305f98311d1c895fd694676d7::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"CHIIKAWA", b"CHIIKAWA ON SUI", b"Chiikawa () is the titular character and protagonist of the viral manga and anime series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZCMC_9_JPDRH_Zx_P_Qcn3bkxi_E511_U_Ggh_Anca_ZG_8z_BBG_Vy_JG_1c35bd3563.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

