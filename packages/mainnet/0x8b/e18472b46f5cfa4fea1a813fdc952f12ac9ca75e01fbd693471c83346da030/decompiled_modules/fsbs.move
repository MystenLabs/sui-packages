module 0x8be18472b46f5cfa4fea1a813fdc952f12ac9ca75e01fbd693471c83346da030::fsbs {
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

