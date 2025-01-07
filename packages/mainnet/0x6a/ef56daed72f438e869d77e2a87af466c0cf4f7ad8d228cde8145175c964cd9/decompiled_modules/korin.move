module 0x6aef56daed72f438e869d77e2a87af466c0cf4f7ad8d228cde8145175c964cd9::korin {
    struct KORIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORIN>(arg0, 6, b"KORIN", b"KORIN SUI", x"4b4f52494e2049532048455245200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W4_Cdd_Y_Esw62knb_L6_Rcs2wms_Zo_EY_5_S_Vs_UEVEUW_Gmh6_M63_5103aceb07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

