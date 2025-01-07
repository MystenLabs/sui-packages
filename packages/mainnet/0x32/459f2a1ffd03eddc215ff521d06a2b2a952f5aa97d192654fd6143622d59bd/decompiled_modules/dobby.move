module 0x32459f2a1ffd03eddc215ff521d06a2b2a952f5aa97d192654fd6143622d59bd::dobby {
    struct DOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBBY>(arg0, 6, b"DOBBY", b"Dobby", b"Choo-wawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tq1b_Wd71n_J2w5_NL_Bhr_Y8_Vrmes_S92vso_S_Bbh_EPCE_Vzy_Zs_3389c54dc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

