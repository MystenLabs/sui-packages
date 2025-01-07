module 0xa53d2044014af709fb3666d6835b7cafd2d2177890143b0f7d863de02eafed87::life {
    struct LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFE>(arg0, 6, b"LIFE", b"Suiit Life", b"CHOOSE $LIFE. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LIFE_Thumby_94f23c64aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

