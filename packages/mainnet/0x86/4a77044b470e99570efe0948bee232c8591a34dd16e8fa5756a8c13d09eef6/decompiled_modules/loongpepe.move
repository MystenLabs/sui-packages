module 0x864a77044b470e99570efe0948bee232c8591a34dd16e8fa5756a8c13d09eef6::loongpepe {
    struct LOONGPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOONGPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOONGPEPE>(arg0, 6, b"LOONGPEPE", b"LOONG PEPE", b"dragon and pepe fly to the moon together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xn_Px_Xgb_AAA_5_S_Qh_c443545126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOONGPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOONGPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

