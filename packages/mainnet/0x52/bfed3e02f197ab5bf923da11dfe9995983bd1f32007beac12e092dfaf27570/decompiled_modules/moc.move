module 0x52bfed3e02f197ab5bf923da11dfe9995983bd1f32007beac12e092dfaf27570::moc {
    struct MOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOC>(arg0, 6, b"MOC", b"Museum Of Currencies", x"4a6f696e20746f206669727374204d757365756d204f662043757272656e63696573206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeb9_J32i_QX_1u_Dv_S_Znz_Hdhn_Meze_Cm_Md6y_S_Lyu_H_Sswrs_PE_2_44491a7e6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

