module 0xeca957482a368e1ee9f58bc0e81691301e24d150aa80d01145edff88248ea550::fsbs {
    struct FSBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSBS>(arg0, 6, b"FSBS", b"fuck school buy sui", b"no more talk just sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xeyd_H_Wbw_AM_Lhv4_b74f941bdd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

