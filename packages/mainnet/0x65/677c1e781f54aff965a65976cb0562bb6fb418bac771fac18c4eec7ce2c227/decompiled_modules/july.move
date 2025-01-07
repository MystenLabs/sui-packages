module 0x65677c1e781f54aff965a65976cb0562bb6fb418bac771fac18c4eec7ce2c227::july {
    struct JULY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JULY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JULY>(arg0, 6, b"JULY", b"JULYs girl", b"The wife of $RAY ROMA is comming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_1aa810d193.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JULY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JULY>>(v1);
    }

    // decompiled from Move bytecode v6
}

