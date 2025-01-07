module 0xebf233152009648b8419c59ffb60daf1818670498b7960c74fba526d83b8a06d::haribond {
    struct HARIBOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARIBOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARIBOND>(arg0, 6, b"HARIBOND", b"HARIBOND SUI", x"546865206f6e6c79206d656d65636f696e207468617420796f752077616e7420746f207374616b652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S4r8_Evmnw_Tj_R_Ds_So_TAC_3_TZJA_Fs_Q7nrbcad_B4_YE_Mxya_Dx_cbda6a2972.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARIBOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARIBOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

