module 0xa191eff9f3bd83eb08d0238cd8f78ccbf7fd17726a4cafa3931daf99e76022d1::atardio {
    struct ATARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATARDIO>(arg0, 6, b"ATARDIO", b"aaaRETARDIO", b"aaaaaaaaaaaa for retardio only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_logo_27487a122f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

