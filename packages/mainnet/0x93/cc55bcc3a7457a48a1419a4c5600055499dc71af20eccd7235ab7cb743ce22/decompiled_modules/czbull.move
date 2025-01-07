module 0x93cc55bcc3a7457a48a1419a4c5600055499dc71af20eccd7235ab7cb743ce22::czbull {
    struct CZBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZBULL>(arg0, 6, b"CZBULL", b"CZ BULL", x"5769746820435a20667265652c20776520617265207374617274696e672074686520626967676573742062756c6c2072756e20696e20686973746f72792e20416e6420696620796f752063616e7420686f6c642c20796f7520776f6e277420626520726963680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc1_PGV_1d_K_Ygyd_UY_Tf_RK_Ax_F_Hr_Zu6rjj6c_As_Y9d_G3_Fvf_P_To_c36850506e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

