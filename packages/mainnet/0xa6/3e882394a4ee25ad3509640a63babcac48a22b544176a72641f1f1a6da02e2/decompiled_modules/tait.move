module 0xa63e882394a4ee25ad3509640a63babcac48a22b544176a72641f1f1a6da02e2::tait {
    struct TAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAIT>(arg0, 6, b"Tait", b"Taity", b"Pump and Dump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_N_D_006a506347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

